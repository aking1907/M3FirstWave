page 50100 "M3 Purchase Proforma Invoices"
{
    Caption = 'Purchase Proforma Invoices';
    PageType = List;
    SourceTable = "M3 Proforma Invoice Header";
    UsageCategory = Lists;
    Editable = false;
    QueryCategory = 'Purch. Proforma Invoices';
    RefreshOnActivate = true;
    CardPageID = "M3 Purch. Proforma Invoice";
    ApplicationArea = All;


    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("No."; Rec."No.")
                {
                    ApplicationArea = All;
                }
                field("Document Date"; Rec."Document Date")
                {
                    ApplicationArea = All;
                }
                field("Loading Point Desc"; Rec."Loading Point Desc")
                {
                    ApplicationArea = All;
                }
                field("Delivery Point No."; Rec."Delivery Point No.")
                {
                    ApplicationArea = All;
                }
                field("Consignee Desc"; Rec."Consignee Desc")
                {
                    ApplicationArea = All;
                }
                field("Delivery Point Desc"; Rec."Delivery Point Desc")
                {
                    ApplicationArea = All;
                }
            }
        }
    }

}
