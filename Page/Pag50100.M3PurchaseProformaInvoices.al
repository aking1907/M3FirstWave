page 50100 "M3 Purchase Proforma Invoices"
{
    Caption = 'M3 Purchase Proforma Invoices';
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
                field("No."; "No.")
                {
                    ApplicationArea = All;
                }
                field("Document Date"; "Document Date")
                {
                    ApplicationArea = All;
                }
                field("Producer No."; "Producer No.")
                {
                    ApplicationArea = All;
                }
                field("Producer Desc"; "Producer Desc")
                {
                    ApplicationArea = All;
                }
                field("Consignee No."; "Consignee No.")
                {
                    ApplicationArea = All;
                }
                field("Consignee Desc"; "Consignee Desc")
                {
                    ApplicationArea = All;
                }
                field("Loading Point No."; "Loading Point No.")
                {
                    ApplicationArea = All;
                }
                field("Loading Point Desc"; "Loading Point Desc")
                {
                    ApplicationArea = All;
                }
                field("Delivery Point No."; "Delivery Point No.")
                {
                    ApplicationArea = All;
                }
                field("Delivery Point Desc"; "Delivery Point Desc")
                {
                    ApplicationArea = All;
                }
            }
        }
    }

}
