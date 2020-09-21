pageextension 50101 "M3 Customer Card Ext." extends "Customer Card"
{
    layout
    {
        addlast(General)
        {
            field("Delivery Basis Desc"; "Delivery Basis Desc")
            {
                ApplicationArea = All;
            }
        }
    }

}
