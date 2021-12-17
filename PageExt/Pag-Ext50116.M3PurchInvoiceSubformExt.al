pageextension 50116 "M3 Purch. Invoice Subform Ext." extends "Purch. Invoice Subform"
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
