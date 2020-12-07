pageextension 50107 "M3 Purch. Order Ext" extends "Purchase Order"
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
        addbefore(PayToOptions)
        {
            field("Delivery Point Code"; Rec."Delivery Point Code")
            {
                ApplicationArea = all;
            }
            field("Delivery Point Name"; Rec."Delivery Point Name")
            {
                ApplicationArea = all;
            }
        }
    }
}
