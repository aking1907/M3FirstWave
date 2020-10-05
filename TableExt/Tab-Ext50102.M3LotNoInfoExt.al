tableextension 50102 "M3 Lot No. Info. Ext." extends "Lot No. Information"
{
    fields
    {
        field(50000; "Container No."; Code[20])
        {
            Caption = 'Container No.';
            DataClassification = ToBeClassified;
        }
        field(50001; "Pure Content, %"; Decimal)
        {
            Caption = 'Pure Content, %';
            DataClassification = ToBeClassified;
            InitValue = 100;
            DecimalPlaces = 0 : 4;
            MinValue = 0;
            MaxValue = 100;

            trigger OnValidate()
            begin
                "Price Net" := Round("Pure Content, %" * "Price Gross" / 100, 0.01, '=');
                Subtotal := Round("Price Net" * "Weight Net", 0.01, '=');
            end;
        }
        field(50002; "Price Gross"; Decimal)
        {
            Caption = 'Price Gross';
            DataClassification = ToBeClassified;
            DecimalPlaces = 0 : 2;
            trigger OnValidate()
            begin
                Validate("Pure Content, %");
            end;
        }
        field(50003; "Price Net"; Decimal)
        {
            Caption = 'Price Net';
            DataClassification = ToBeClassified;
            DecimalPlaces = 0 : 2;
            trigger OnValidate()
            begin
                Subtotal := Round("Price Net" * "Weight Net", 0.01, '=');
            end;
        }
        field(50004; "Weight Gross"; Decimal)
        {
            Caption = 'Weight Gross';
            DataClassification = ToBeClassified;
            DecimalPlaces = 0 : 3;
        }
        field(50005; "Weight Net"; Decimal)
        {
            Caption = 'Weight Net';
            DataClassification = ToBeClassified;
            DecimalPlaces = 0 : 3;

            trigger OnValidate()
            begin
                Validate("Pure Content, %");
            end;
        }
        field(50006; "Currency Code"; Code[5])
        {
            Caption = 'Currency Code';
            DataClassification = ToBeClassified;
            TableRelation = Currency;
        }
        field(50007; "Unit of Measure Code"; Code[10])
        {
            Caption = 'Unit of Measure Code';
            DataClassification = ToBeClassified;
            TableRelation = "Unit of Measure";
        }
        field(50008; Size; Text[30])
        {
            Caption = 'Size';
            DataClassification = ToBeClassified;
        }
        field(50009; Origin; Text[50])
        {
            Caption = 'Origin';
            DataClassification = ToBeClassified;
            TableRelation = "Country/Region";
        }
        field(50010; Subtotal; Decimal)
        {
            Caption = 'Subtotal';
            DataClassification = ToBeClassified;
        }
        field(50011; "Proforma Invoice No."; Code[20])
        {
            Caption = 'Proforma Invoice No.';
            DataClassification = ToBeClassified;
            TableRelation = "M3 Proforma Invoice Header";
        }
        field(50012; "Item Desc"; Text[100])
        {
            Caption = 'Item Desc';
            DataClassification = ToBeClassified;
        }
        field(50013; "Producer No."; Code[20])
        {
            Caption = 'Producer No.';
            DataClassification = ToBeClassified;
            TableRelation = Vendor;

            trigger OnValidate()
            var
                Vendor: Record Vendor;
            begin
                "Producer Name" := '';
                if Vendor.Get("Producer No.") then begin
                    "Producer Name" := Vendor.Name;
                    Origin := Vendor."Country/Region Code";
                end;
            end;
        }
        field(50014; "Producer Name"; Text[100])
        {
            Caption = 'Producer No.';
            DataClassification = ToBeClassified;
        }
        field(50015; "Item Abbreviation Code"; Code[20])
        {
            Caption = 'Item Abbreviation Code';
            DataClassification = ToBeClassified;
        }
    }

    trigger OnAfterInsert();
    var
        Item: Record Item;
    begin
        if item.Get("Item No.") then begin
            "Item Desc" := Item.Description;
            "Item Abbreviation Code" := Item."Abbreviation Code";
            "Unit of Measure Code" := Item."Base Unit of Measure";
            Size := Item.Size;
            Modify();
        end;
    end;
}
