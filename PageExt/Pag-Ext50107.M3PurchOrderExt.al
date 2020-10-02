pageextension 50107 "M3 Purch. Order Ext" extends "Purchase Order"
{
    layout
    {
        addafter(Status)
        {
            field("Delivery Point Code"; "Delivery Point Code")
            {
                ApplicationArea = all;
            }
            field("Delivery Point Name"; "Delivery Point Name")
            {
                ApplicationArea = all;
            }
        }
    }
}
