pageextension 50110 "M3 Bank Account List Ext." extends "Bank Account List"
{
    layout
    {
        addafter(Contact)
        {
            field(Balance; Rec.Balance)
            {
                ApplicationArea = All;
            }
            field("Balance (LCY)"; Rec."Balance (LCY)")
            {
                ApplicationArea = All;
            }
            field("Balance at Date"; Rec."Balance at Date")
            {
                ApplicationArea = All;
                Visible = false;
            }
            field("Balance at Date (LCY)"; Rec."Balance at Date (LCY)")
            {
                ApplicationArea = All;
                Visible = false;
            }
        }
    }
}
