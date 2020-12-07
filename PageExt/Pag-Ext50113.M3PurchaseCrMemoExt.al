pageextension 50113 "M3 Purchase Cr. Memo Ext." extends "Purchase Credit Memo"
{
    layout
    {
        addafter("Vendor Cr. Memo No.")
        {
            field("Posting No."; Rec."Posting No.")
            {
                ApplicationArea = All;
                Editable = true;
            }
        }
    }
}
