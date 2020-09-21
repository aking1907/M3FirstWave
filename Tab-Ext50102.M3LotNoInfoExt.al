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
        }
        field(50002; "Price Gross"; Decimal)
        {
            Caption = 'Price Gross';
            DataClassification = ToBeClassified;
        }
        field(50003; "Price Net"; Decimal)
        {
            Caption = 'Price Net';
            DataClassification = ToBeClassified;
        }
        field(50004; "Weight Gross"; Decimal)
        {
            Caption = 'Weight Gross';
            DataClassification = ToBeClassified;
        }
        field(50005; "Weight Net"; Decimal)
        {
            Caption = 'Weight Net';
            DataClassification = ToBeClassified;
        }
        field(50006; "Currency Code"; Code[5])
        {
            Caption = 'Currency Code';
            DataClassification = ToBeClassified;
        }
        field(50007; "Unit of Measure Code"; Code[10])
        {
            Caption = 'Unit of Measure Code';
            DataClassification = ToBeClassified;
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
        }
        field(50010; Subtotal; Decimal)
        {
            Caption = 'Subtotal';
            DataClassification = ToBeClassified;
        }
    }
}
