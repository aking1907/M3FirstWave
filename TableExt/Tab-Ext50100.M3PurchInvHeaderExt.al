tableextension 50100 "M3 Purch. Inv. Header Ext." extends "Purch. Inv. Header"
{
    fields
    {
        field(50000; "Proforma Invoice No."; Code[20])
        {
            Caption = 'Proforma Invoice No.';
            TableRelation = "M3 Proforma Invoice Header";
        }
        field(90000; "Delivery Point Code"; Code[20])
        {
            Caption = 'Delivery Point Code';
            DataClassification = ToBeClassified;
            TableRelation = Location;

        }
        field(90001; "Delivery Point Name"; Text[80])
        {
            Caption = 'Delivery Point Name';
            FieldClass = FlowField;
            CalcFormula = lookup(Location.Name where(Code = field("Delivery Point Code")));
        }
    }
}
