tableextension 50100 "M3 Purch. Inv. Header Ext." extends "Purch. Inv. Header"
{
    fields
    {
        field(50000; "Proforma Invoice No."; Code[20])
        {
            Caption = 'Proforma Invoice No.';
            DataClassification = ToBeClassified;
        }
        field(50001; "Proforma Invoice Date"; Date)
        {
            Caption = 'Proforma Invoice Date';
            DataClassification = ToBeClassified;
        }
    }
}
