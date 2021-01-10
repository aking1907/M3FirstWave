pageextension 50114 "M3 Purchase Order Subform Ext." extends "Purchase Order Subform"
{
    layout
    {
        addafter("VAT Prod. Posting Group")
        {
            field("Gen. Prod. Posting Group"; Rec."Gen. Prod. Posting Group")
            {
                ApplicationArea = All;
                Editable = true;
                Visible = true;
            }
        }
    }
}
