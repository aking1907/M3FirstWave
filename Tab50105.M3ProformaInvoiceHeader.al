table 50105 "M3 Proforma Invoice Header"
{
    Caption = 'M3 Proforma Invoice Header';
    DataClassification = ToBeClassified;

    fields
    {
        field(10; "No."; Code[10])
        {
            Caption = 'No.';
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

    var
        LblChangeConfirmation: Label 'Do you want to change %1?';

    procedure CopyFromPurchInvoice(var PurchInvoice: Record "Purch. Inv. Header")
    var
        Vendor: Record Vendor;
    begin
        Validate("Shipper No.", PurchInvoice."Buy-from Vendor No.");
        Validate("Producer No.", PurchInvoice."Buy-from Vendor No.");
        Validate("Consignee No.", PurchInvoice."Pay-to Contact No.");
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
}
