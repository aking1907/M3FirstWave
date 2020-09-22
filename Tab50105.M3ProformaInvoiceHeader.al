table 50105 "M3 Proforma Invoice Header"
{
    Caption = 'M3 Proforma Invoice Header';
    DataClassification = ToBeClassified;
    Permissions = tabledata 122 = rimd;
    LookupPageId = "M3 Purch. Proforma Invoice";
    DrillDownPageId = "M3 Purch. Proforma Invoice";
    DataCaptionFields = "No.", "Producer No.", "Shipper No.";

    fields
    {
        field(10; "No."; Code[10])
        {
            Caption = 'No.';
            Editable = false;
            DataClassification = ToBeClassified;
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
        field(60; "Producer No."; Code[10])
        {
            Caption = 'Producer No.';
            DataClassification = ToBeClassified;
            TableRelation = Vendor;

            trigger OnValidate()
            var
                Vendor: Record Vendor;
            begin
                "Producer Desc" := '';
                if Vendor.Get("Producer No.") then
                    "Producer Desc" := Vendor.Name;
            end;
        }
        field(70; "Producer Desc"; Text[250])
        {
            Caption = 'Producer Desc';
            DataClassification = ToBeClassified;
        }
        field(80; "Consignee No."; Code[10])
        {
            Caption = 'Consignee No.';
            DataClassification = ToBeClassified;
            TableRelation = Customer;

            trigger OnValidate()
            var
                Cust: Record Customer;
            begin
                "Consignee Desc" := '';
                if not Cust.Get("Consignee No.") then exit;

                "Consignee Desc" := Cust.Name;
                "Delivery Basis Desc" := Cust."Delivery Basis Desc";
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
            begin
                "Delivery Point Desc" := '';
                if Loc.Get("Delivery Point No.") then
                    "Delivery Point Desc" := Loc.Name;
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
        field(150; "Delivery Basis Desc"; Text[250])
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

    var
        LblChangeConfirmation: Label 'Do you want to change %1?';
        NoSerMgt: Codeunit NoSeriesManagement;

    procedure CopyFromPurchInvoice(var PurchInvoice: Record "Purch. Inv. Header")
    var
        Vendor: Record Vendor;
    begin
        Validate("Shipper No.", PurchInvoice."Buy-from Vendor No.");
        Validate("Producer No.", PurchInvoice."Buy-from Vendor No.");
        Validate("Consignee No.", PurchInvoice."Sell-to Customer No.");
        Validate("Delivery Basis", PurchInvoice."Shipment Method Code");

        if Vendor.Get(PurchInvoice."Buy-from Vendor No.") then
            "Delivery Basis Desc" := 'to fill ...';

    end;

    local procedure GetAddress(ArrayLines: Array[10] of Text[150]): Text
    var
        FullAddress: Text[500];
        i: Integer;
    begin
        for i := 1 to 10 do begin
            if ArrayLines[i] <> '' then FullAddress += ', ' + ArrayLines[i];
        end;
        exit(DelChr(FullAddress, '<>', ','));
    end;

    procedure UpsertProformaInvoice(var PurchInvHeader: Record "Purch. Inv. Header")
    var
        ProfInv: Record "M3 Proforma Invoice Header";
        PIH: Record "Purch. Inv. Header";
    begin
        if not PurchInvHeader.FindSet() then exit;

        PIH.Copy(PurchInvHeader);
        PIH.SetFilter("Proforma Invoice No.", '<>%1', '');
        if PIH.FindFirst() then begin
            if PurchInvHeader.FindSet() then
                repeat
                    PurchInvHeader.TestField("Buy-from Vendor No.", PIH."Buy-from Vendor No.");
                    PurchInvHeader.TestField("Shipment Method Code", PIH."Shipment Method Code");
                    if PurchInvHeader."Proforma Invoice No." <> '' then
                        PurchInvHeader.TestField("Proforma Invoice No.", PIH."Proforma Invoice No.");

                until PurchInvHeader.Next() = 0;

            PurchInvHeader.ModifyAll("Proforma Invoice No.", PIH."Proforma Invoice No.");
            UpdateLotNo(PurchInvHeader);
            exit;
        end;

        ProfInv."No." := NoSerMgt.GetNextNo('PURCHPI', WorkDate(), true);
        ProfInv."Document Date" := WorkDate();
        ProfInv.Insert(true);

        PurchInvHeader.ModifyAll("Proforma Invoice No.", ProfInv."No.");
        UpdateLotNo(PurchInvHeader);

        PurchInvHeader.FindFirst();
        ProfInv.CopyFromPurchInvoice(PurchInvHeader);
        ProfInv.Modify(true);
    end;

    procedure RemovePIFromProformaInvoice(var PurchInvHeader: Record "Purch. Inv. Header")
    var
        PI: Record "M3 Proforma Invoice Header";
        PIH: Record "Purch. Inv. Header";
        DocumentNo: Code[20];
    begin
        PIH.Copy(PurchInvHeader);
        PIH.SetFilter("Proforma Invoice No.", '<>%1', '');
        if not PIH.FindSet() then exit;
        DocumentNo := PIH."Proforma Invoice No.";

        repeat
            PIH.TestField("Proforma Invoice No.", DocumentNo);
            PIH."Proforma Invoice No." := '';
            PIH.Modify();
        until PIH.Next() = 0;

        PIH.Reset();
        PIH.SetRange("Proforma Invoice No.", DocumentNo);
        if not PIH.FindFirst() then
            if PI.Get(DocumentNo) then
                PI.Delete();

    end;

    local procedure UpdateLotNo(var PurchInvHeader: Record "Purch. Inv. Header")
    var
        ILE: Record "Item Ledger Entry";
        LOT: Record "Lot No. Information";

    begin
        if PurchInvHeader.FindSet() then
            repeat
            
                ILE.SetRange("Document No.", PurchInvHeader."No.");
                ILE.SetRange("Document Type", ILE."Document Type"::"Purchase Invoice");
                if ILE.FindSet() then
                    repeat
                        LOT.Get(ILE."Item No.", ILE."Variant Code", ILE."Lot No.");
                        LOT."Certificate Number" := PurchInvHeader."No.";
                        LOT.Modify();
                    until ILE.Next() = 0;
            until PurchInvHeader.Next() = 0;
    end;
}
