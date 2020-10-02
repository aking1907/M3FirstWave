pageextension 50102 "M3 Lot No. Info Card Ext." extends "Lot No. Information Card"
{
    layout
    {
        modify("Certificate Number")
        {
            Editable = false;
        }
        addafter("Certificate Number")
        {
            field("Proforma Invoice No."; "Proforma Invoice No.")
            {
                Editable = false;
                ApplicationArea = All;
            }
        }
        addafter(General)
        {
            group(Shipmrnt)
            {
                Caption = 'Shipment Information';

                field("Producer No."; "Producer No.")
                {
                    ApplicationArea = All;
                }
                field("Producer Name"; "Producer Name")
                {
                    ApplicationArea = All;
                }
                field("Container No."; "Container No.")
                {
                    ApplicationArea = All;
                }
                field("Item Desc"; "Item Desc")
                {
                    ApplicationArea = All;
                }
                field("Pure Content, %"; "Pure Content, %")
                {
                    ApplicationArea = All;
                }
                field("Currency Code"; "Currency Code")
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
                field(Subtotal; Subtotal)
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
            }

        }

        // addbefore(Control1900383207)
        // {
        //     part("Attached Documents"; "Document Attachment Factbox")
        //     {
        //         ApplicationArea = All;
        //         Caption = 'Attachments';
        //         SubPageLink = "Table ID" = CONST(6505),
        //                       "No." = FIELD("Lot No."),
        //                       "Document Type" = ;
        //     }
        // }
    }
}

