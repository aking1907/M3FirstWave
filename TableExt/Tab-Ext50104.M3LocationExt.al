tableextension 50104 "M3 Location Ext." extends Location
{
    fields
    {
        field(50000; "Proforma Contract Text"; Text[2048])
        {
            Caption = 'Proforma Contract Text';
            DataClassification = ToBeClassified;
        }
    }
}
