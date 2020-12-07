pageextension 50109 "M3 Sales Invoice Ext." extends "Sales Invoice"
{
    layout
    {
        addafter("External Document No.")
        {
            field("Posting No."; Rec."Posting No.")
            {
                ApplicationArea = All;
                Editable = true;
            }
        }
    }
}
