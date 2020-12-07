pageextension 50112 "M3 Purchase Invoice Ext." extends "Purchase Invoice"
{
    layout
    {
        addafter("Vendor Invoice No.")
        {
            field("Posting No."; Rec."Posting No.")
            {
                ApplicationArea = All;
                Editable = true;
            }
        }
    }
}
