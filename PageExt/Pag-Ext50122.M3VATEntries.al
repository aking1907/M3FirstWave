pageextension 50122 "M3 VAT Entries" extends "VAT Entries"
{
    layout
    {
        addafter("Additional-Currency Amount")
        {
            field("Currency Code"; Rec."Currency Code")
            {
                ApplicationArea = All;
                Editable = false;
            }
            field("Base (FCY)"; Rec."Base (FCY)")
            {
                ApplicationArea = All;
                Editable = false;
            }
            field("Amount (FCY)"; Rec."Amount (FCY)")
            {
                ApplicationArea = All;
                Editable = false;
            }
        }
    }
}
