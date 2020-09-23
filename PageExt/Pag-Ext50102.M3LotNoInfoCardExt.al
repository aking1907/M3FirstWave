pageextension 50102 "M3 Lot No. Info Card Ext." extends "Lot No. Information Card"
{
    layout
    {
        addafter(General)
        {
            group(Shipmrnt)
            {
                Caption = 'Shipment Information';

                field("Container No."; "Container No.")
                {
                    ApplicationArea = All;
                }
                field("Pure Content, %"; "Pure Content, %")
                {
                    ApplicationArea = All;
                }
                field("Item Desc"; "Item Desc")
                {
                    ApplicationArea = All;
                }
                field("Price Gross"; "Price Gross")
                {
                    ApplicationArea = All;
                }
                field("Price Net"; "Price Net")
                {
                    ApplicationArea = All;
                }
                field("Weight Gross"; "Weight Gross")
                {
                    ApplicationArea = All;
                }
                field("Weight Net"; "Weight Net")
                {
                    ApplicationArea = All;
                }
                field("Unit of Measure Code"; "Unit of Measure Code")
                {
                    ApplicationArea = All;
                }
                field(Size; Size)
                {
                    ApplicationArea = All;
                }
                field(Origin; Origin)
                {
                    ApplicationArea = All;
                }
                field(Subtotal; Subtotal)
                {
                    ApplicationArea = All;
                }
            }
        }
    }
}

