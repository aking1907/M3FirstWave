pageextension 50118 "M3 Sales Cr. Memo Sub. Ext." extends "Sales Cr. Memo Subform"
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
