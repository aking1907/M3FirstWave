pageextension 50107 "M3 Purch. Order Ext" extends "Purchase Order"
{
    layout
    {
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
