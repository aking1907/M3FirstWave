pageextension 50115 "M3 Sales Order Subform Ext." extends "Sales Order Subform"
{
    layout
    {
        addafter("VAT Prod. Posting Group")
        {
            field("Gen. Prod. Posting Group"; Rec."Gen. Prod. Posting Group")
            {
                ApplicationArea = All;
                Editable = true;
            }
        }
    }
}
