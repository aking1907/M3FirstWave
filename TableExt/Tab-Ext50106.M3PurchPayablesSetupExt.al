tableextension 50106 "M3 Purch. & Pay. Setup Ext." extends "Purchases & Payables Setup"
{
    fields
    {
        field(50000; "Proforma Invoice Nos."; Code[20])
        {
            Caption = 'Proforma Invoice Nos.';
            TableRelation = "No. Series";
            DataClassification = ToBeClassified;
        }
    }
}
