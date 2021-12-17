pageextension 50117 "M3 Sales Invoice Subform Ext." extends "Sales Invoice Subform"
{
    layout
    {
        modify("Gen. Prod. Posting Group")
        {
            ApplicationArea = All;
            Editable = true;
            Visible = true;
        }
        moveafter("VAT Prod. Posting Group"; "Gen. Prod. Posting Group")
    }
}

