tableextension 50101 "M3 Customer Ext." extends Customer
{
    fields
    {
        field(50000; "Delivery Basis Desc"; Text[150])
        {
            Caption = 'Delivery Basis Desc';
            DataClassification = ToBeClassified;
        }
    }
}
