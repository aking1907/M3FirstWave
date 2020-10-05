pageextension 50104 "Payment Journal Ext." extends "Payment Journal"
{
    layout
    {
        addafter("Account Type")
        {
            field("Posting Group"; Rec."Posting Group")
            {
                ApplicationArea = All;
                Editable = true;
            }
        }
    }
}
