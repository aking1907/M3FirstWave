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
            field("Proforma Invoice No."; Rec."Proforma Invoice No.")
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

                field("Producer No."; Rec."Producer No.")
                {
                    ApplicationArea = All;
                }
                field("Producer Name"; Rec."Producer Name")
                {
                    ApplicationArea = All;
                }
                field("Container No."; Rec."Container No.")
                {
                    ApplicationArea = All;
                }
                field("Item Desc"; Rec."Item Desc")
                {
                    ApplicationArea = All;
                }
                field("Item Abbreviation Code"; Rec."Item Abbreviation Code")
                {
                    ApplicationArea = All;
                }
                field("Pure Content, %"; Rec."Pure Content, %")
                {
                    ApplicationArea = All;
                }
                field("Currency Code"; Rec."Currency Code")
                {
                    ApplicationArea = All;
                }
                field("Price Gross"; Rec."Price Gross")
                {
                    ApplicationArea = All;
                }
                field("Price Net"; Rec."Price Net")
                {
                    ApplicationArea = All;
                }
                field(Subtotal; Rec.Subtotal)
                {
                    ApplicationArea = All;
                }
                field("Weight Gross"; Rec."Weight Gross")
                {
                    ApplicationArea = All;
                }
                field("Weight Net"; Rec."Weight Net")
                {
                    ApplicationArea = All;
                }
                field("Unit of Measure Code"; Rec."Unit of Measure Code")
                {
                    ApplicationArea = All;
                }
                field(Size; Rec.Size)
                {
                    ApplicationArea = All;
                }
                field(Origin; Rec.Origin)
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

