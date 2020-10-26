table 50105 "M3 Proforma Invoice Header"
{
    Caption = 'Proforma Invoice Header';
    DataClassification = ToBeClassified;
    Permissions = tabledata 122 = rimd, tabledata 6505 = rimd, tabledata 32 = rimd;
    LookupPageId = "M3 Purch. Proforma Invoice";
    DrillDownPageId = "M3 Purchase Proforma Invoices";
    DataCaptionFields = "No.";

    fields
    {
        field(10; "No."; Code[10])
        {
            Caption = 'No.';
            DataClassification = ToBeClassified;
            NotBlank = true;
            Editable = false;
        }
        field(20; "Document Date"; Date)
        {
            Caption = 'Document Date';
            DataClassification = ToBeClassified;
        }
        field(40; "Shipper No."; Code[10])
        {
            Caption = 'Shipper No.';
            DataClassification = ToBeClassified;
            TableRelation = Vendor;

            trigger OnValidate()
            var
                ArrayData: Array[10] of Text[150];
                Country: Record "Country/Region";
                Vendor: Record Vendor;
            begin
                if ("Shipper No." <> xRec."Shipper No.") and ("Shipper Desc" <> '') then
                    if not Confirm(StrSubstNo(LblChangeConfirmation, FieldCaption("Shipper Desc"), false)) then
                        exit;

                "Shipper Desc" := '';
                if not Vendor.Get("Shipper No.") then exit;

                ArrayData[1] := Vendor.Name;
                ArrayData[2] := Vendor.Address;
                ArrayData[3] := Vendor."Address 2";
                ArrayData[4] := Vendor."Post Code" + ' ' + Vendor."City";
                if Country.Get(Vendor."Country/Region Code") then begin
                    ArrayData[4] := Country.Name;
                end;

                "Shipper Desc" := GetAddress(ArrayData);
            end;
        }
        field(50; "Shipper Desc"; Text[250])
        {
            Caption = 'Shipper Desc';
            DataClassification = ToBeClassified;
        }
        field(80; "Consignee No."; Code[10])
        {
            Caption = 'Consignee No.';
            DataClassification = ToBeClassified;
            TableRelation = Location;

            trigger OnValidate()
            var
                Loc: Record Location;
            begin
                "Consignee Desc" := '';
                if Loc.Get("Consignee No.") then
                    "Consignee Desc" := Loc.Name;
            end;
        }
        field(90; "Consignee Desc"; Text[250])
        {
            Caption = 'Consignee Desc';
            DataClassification = ToBeClassified;
        }
        field(100; "Loading Point No."; Code[10])
        {
            Caption = 'Loading Point No.';
            DataClassification = ToBeClassified;
            TableRelation = Location;

            trigger OnValidate()
            var
                Loc: Record Location;
            begin
                "Loading Point Desc" := '';
                if Loc.Get("Loading Point No.") then
                    "Loading Point Desc" := Loc.Name;
            end;
        }
        field(110; "Loading Point Desc"; Text[250])
        {
            Caption = 'Loading Point Desc';
            DataClassification = ToBeClassified;
        }
        field(120; "Delivery Point No."; Code[10])
        {
            Caption = 'Delivery Point No.';
            DataClassification = ToBeClassified;
            TableRelation = Location;

            trigger OnValidate()
            var
                Loc: Record Location;
                PIH: Record "Purch. Inv. Header";
            begin
                "Delivery Point Desc" := '';
                validate("Consignee No.", '');
                "Delivery Basis" := '';
                "Delivery Basis Desc" := '';

                PIH.SetRange("Proforma Invoice No.", "No.");
                if PIH.FindFirst() then
                    "Delivery Basis" := PIH."Shipment Method Code";

                if not Loc.Get("Delivery Point No.") then exit;

                Validate("Consignee No.", "Delivery Point No.");
                "Delivery Basis" := DelChr("Delivery Basis" + ' ' + loc.City, '<>');
                "Delivery Point Desc" := Loc.Name;
                "Delivery Basis Desc" := Loc."Proforma Contract Text";
            end;
        }
        field(130; "Delivery Point Desc"; Text[150])
        {
            Caption = 'Delivery Point Desc';
            DataClassification = ToBeClassified;
        }
        field(140; "Delivery Basis"; Text[100])
        {
            Caption = 'Delivery Basis';
            DataClassification = ToBeClassified;
        }
        field(150; "Delivery Basis Desc"; Text[2048])
        {
            Caption = 'Delivery Basis Desc';
            DataClassification = ToBeClassified;
        }
        field(160; Created; DateTime)
        {
            Caption = 'Created';
            Editable = false;
            DataClassification = ToBeClassified;
        }

        field(170; "Created By"; Code[20])
        {
            Caption = 'Created By';
            Editable = false;
            DataClassification = ToBeClassified;
        }

        field(180; Updated; DateTime)
        {
            Caption = 'Updated';
            Editable = false;
            DataClassification = ToBeClassified;
        }

        field(190; "Updated By"; Code[20])
        {
            Caption = 'Updated By';
            Editable = false;
            DataClassification = ToBeClassified;
        }
    }
    keys
    {
        key(PK; "No.")
        {
            Clustered = true;
        }
    }
    fieldgroups
    {
        fieldgroup(DropDown; "No.", "Document Date", "Delivery Point No.")
        {
        }
    }

    trigger OnInsert()
    begin
        Created := CurrentDateTime;
        "Created By" := UserId;
        Updated := CurrentDateTime;
        "Updated By" := UserId;
    end;

    trigger OnModify()
    begin
        Updated := CurrentDateTime;
        "Updated By" := UserId;
    end;

    trigger OnDelete()
    var
        PIH: Record "Purch. Inv. Header";
    begin
        PIH.SetRange("Proforma Invoice No.", "No.");
        if not pih.IsEmpty then
            PIH.ModifyAll("Proforma Invoice No.", '');
    end;

    var
        LblChangeConfirmation: Label 'Do you want to change %1?';
        NoSerMgt: Codeunit NoSeriesManagement;
        ErrAssignProfInvNo: Label 'Lot No. was not found for Invoice No. = %1, Line No. = %2.  Proforma Invoice No. can not be assigned to the document.';
        ErrItemNotFound: Label 'Invoice No. = %1 does not contain lines with the Type equal Item. Proforma Invoice No. can not be assigned to the document.';

    procedure CopyFromPurchInvoice(var PurchInvoice: Record "Purch. Inv. Header")
    var
        OrderAddress: Record "Order Address";
        ArrayData: Array[10] of Text[150];
        Country: Record "Country/Region";
    begin
        Validate("Shipper No.", PurchInvoice."Buy-from Vendor No.");
        Validate("Delivery Point No.", PurchInvoice."Delivery Point Code");
        //Validate("Delivery Basis", PurchInvoice."Shipment Method Code");

        "Loading Point Desc" := "Shipper Desc";
        if OrderAddress.Get(PurchInvoice."Buy-from Vendor No.", PurchInvoice."Order Address Code") then begin
            ArrayData[1] := OrderAddress.Name;
            ArrayData[2] := OrderAddress.Address;
            ArrayData[3] := OrderAddress."Address 2";
            ArrayData[4] := OrderAddress."Post Code" + ' ' + OrderAddress."City";
            if Country.Get(OrderAddress."Country/Region Code") then begin
                ArrayData[5] := Country.Name;
            end;

            "Loading Point Desc" := GetAddress(ArrayData);

        end;

    end;

    local procedure GetAddress(ArrayLines: Array[10] of Text[150]): Text
    var
        FullAddress: Text[500];
        i: Integer;
    begin
        for i := 1 to 10 do begin
            if ArrayLines[i] <> '' then FullAddress += ', ' + ArrayLines[i];
        end;
        exit(DelChr(DelChr(FullAddress, '<>', ','), '<>', ' '));
    end;

    procedure UpsertProformaInvoice(var PurchInvHeader: Record "Purch. Inv. Header")
    var
        ProfInv: Record "M3 Proforma Invoice Header";
        PIH: Record "Purch. Inv. Header";
        PurchSetup: Record "Purchases & Payables Setup";
        DocumentNo: Code[20];
    begin
        if not PurchInvHeader.FindSet() then exit;

        PIH.Copy(PurchInvHeader);
        PIH.SetFilter("Proforma Invoice No.", '<>%1', '');
        if PIH.FindFirst() then begin
            DocumentNo := PIH."Proforma Invoice No.";
            if PurchInvHeader.FindSet() then
                repeat
                    PurchInvHeader.TestField("Buy-from Vendor No.", PIH."Buy-from Vendor No.");
                    PurchInvHeader.TestField("Shipment Method Code", PIH."Shipment Method Code");
                    if PurchInvHeader."Proforma Invoice No." <> '' then
                        PurchInvHeader.TestField("Proforma Invoice No.", DocumentNo);

                until PurchInvHeader.Next() = 0;

            if PurchInvHeader.FindSet() then
                repeat
                    PIH.Reset();
                    PIH.SetRange("No.", PurchInvHeader."No.");
                    if UpdateLotNo(PIH, DocumentNo) then begin
                        PurchInvHeader."Proforma Invoice No." := DocumentNo;
                        PurchInvHeader.Modify();
                    end;
                until PurchInvHeader.Next() = 0;
            exit;
        end;

        PurchSetup.Get();
        PurchSetup.TestField("Proforma Invoice Nos.");
        DocumentNo := NoSerMgt.GetNextNo(PurchSetup."Proforma Invoice Nos.", WorkDate(), true);
        ProfInv."No." := DocumentNo;
        ProfInv."Document Date" := WorkDate();
        ProfInv.Insert(true);

        if PurchInvHeader.FindSet() then
            repeat
                PIH.Reset();
                PIH.SetRange("No.", PurchInvHeader."No.");
                if UpdateLotNo(PIH, DocumentNo) then begin
                    PurchInvHeader."Proforma Invoice No." := DocumentNo;
                    PurchInvHeader.Modify();
                end;
            until PurchInvHeader.Next() = 0;

        PurchInvHeader.FindFirst();
        ProfInv.CopyFromPurchInvoice(PurchInvHeader);
        ProfInv.Modify(true);

    end;

    procedure RemovePIFromProformaInvoice(var PurchInvHeader: Record "Purch. Inv. Header")
    var
        PI: Record "M3 Proforma Invoice Header";
        PIH: Record "Purch. Inv. Header";
        PIHtmp: Record "Purch. Inv. Header" temporary;
        DocumentNo: Code[20];
    begin
        PIH.Copy(PurchInvHeader);
        PIH.SetFilter("Proforma Invoice No.", '<>%1', '');
        if not PIH.FindSet() then exit;
        DocumentNo := PIH."Proforma Invoice No.";

        repeat
            PIH.TestField("Proforma Invoice No.", DocumentNo);
            PIHtmp.Copy(PIH);
            PIHtmp.Insert();
        until PIH.Next() = 0;

        if PIHtmp.FindSet() then
            repeat
                PIH.Reset();
                PIH.SetRange("No.", PIHtmp."No.");
                PIH.FindFirst();
                PIH."Proforma Invoice No." := '';
                PIH.Modify();
                if UpdateLotNo(PIH, PIH."Proforma Invoice No.") then;
            until PIHtmp.Next() = 0;

        PIH.Reset();
        PIH.SetRange("Proforma Invoice No.", DocumentNo);
        if not PIH.FindFirst() then
            if PI.Get(DocumentNo) then
                PI.Delete();

    end;

    local procedure UpdateLotNo(var PurchInvHeader: Record "Purch. Inv. Header"; DocumentNo: Code[20]): Boolean
    var
        TmpILE: Record "Item Ledger Entry" temporary;
        LOT: Record "Lot No. Information";
        ItemTrackingDocMgt: Codeunit "Item Tracking Doc. Management";
        PurchInvLine: Record "Purch. Inv. Line";
        IsResult: Boolean;
    begin
        if not TmpILE.IsTemporary then Error('');
        IsResult := false;
        if PurchInvHeader.FindSet() then
            repeat
                PurchInvLine.SetRange("Document No.", PurchInvHeader."No.");
                PurchInvLine.SetRange(Type, PurchInvLine.Type::Item);
                if PurchInvLine.FindSet() then begin
                    repeat
                        TmpILE.Reset();
                        TmpILE.DeleteAll();
                        ItemTrackingDocMgt.RetrieveEntriesFromPostedInvoice(TmpILE, PurchInvLine.RowID1());
                        if TmpILE.FindSet() then begin
                            repeat
                                if TmpILE."Lot No." <> '' then
                                    if LOT.Get(TmpILE."Item No.", TmpILE."Variant Code", TmpILE."Lot No.") then begin
                                        LOT."External Document No." := PurchInvHeader."No.";
                                        LOT."Proforma Invoice No." := DocumentNo;

                                        if DocumentNo = '' then begin
                                            LOT."External Document No." := '';
                                        end else begin
                                            if LOT."Item Desc" = '' then
                                                LOT."Item Desc" := PurchInvLine.Description;
                                            if LOT.Origin = '' then
                                                LOT.Origin := '';
                                            if LOT."Price Net" = 0 then
                                                LOT."Price Net" := LOT."Price Net" * LOT."Pure Content, %" / 100;
                                            if LOT."Currency Code" = '' then
                                                LOT."Currency Code" := PurchInvHeader."Currency Code";
                                            if LOT."Unit of Measure Code" = '' then
                                                LOT."Unit of Measure Code" := PurchInvLine."Unit of Measure Code";
                                            if LOT."Weight Gross" = 0 then
                                                LOT."Weight Gross" := PurchInvLine."Gross Weight";
                                            if LOT."Weight Net" = 0 then
                                                LOT."Weight Net" := PurchInvLine."Net Weight";
                                        end;


                                        LOT.Modify();
                                        IsResult := true;
                                    end;
                            until TmpILE.Next() = 0;
                        end else
                            Message(ErrAssignProfInvNo, PurchInvLine."Document No.", PurchInvLine."Line No.");
                    until PurchInvLine.Next() = 0;
                end else
                    Message(ErrItemNotFound, PurchInvLine."Document No.");
            until PurchInvHeader.Next() = 0;

        exit(IsResult);
    end;
}
