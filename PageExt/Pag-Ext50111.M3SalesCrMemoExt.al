pageextension 50111 "M3 Sales Cr. Memo Ext." extends "Sales Credit Memo"
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
