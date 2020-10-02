tableextension 50105 "M3 Purchase Header Ext." extends "Purchase Header"
{
    fields
    {
        field(90000; "Delivery Point Code"; Code[20])
        {
            Caption = 'Delivery Point Code';
            DataClassification = ToBeClassified;
            TableRelation = Location;

            trigger OnValidate()
            begin
                CalcFields("Delivery Point Name");
            end;
        }
        field(90001; "Delivery Point Name"; Text[80])
        {
            Caption = 'Delivery Point Name';
            FieldClass = FlowField;
            CalcFormula = lookup (Location.Name where(Code = field("Delivery Point Code")));
        }

    }
}
