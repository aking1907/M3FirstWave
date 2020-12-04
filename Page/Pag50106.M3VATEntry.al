page 50106 "M3 VAT Entries"
{
    ApplicationArea = Basic, Suite;
    Caption = 'VAT Entries Admin';
    DeleteAllowed = false;
    InsertAllowed = true;
    PageType = List;
    Permissions = TableData "VAT Entry" = rimd;
    SourceTable = "VAT Entry";
    UsageCategory = History;

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("Add.-Curr. Realized Amount"; Rec."Add.-Curr. Realized Amount")
                {
                    ApplicationArea = All;
                    Editable = true;
                }
                field("Add.-Curr. Realized Base"; Rec."Add.-Curr. Realized Base")
                {
                    ApplicationArea = All;
                    Editable = true;
                }
                field("Add.-Curr. Rem. Unreal. Amount"; Rec."Add.-Curr. Rem. Unreal. Amount")
                {
                    ApplicationArea = All;
                    Editable = true;
                }
                field("Add.-Curr. Rem. Unreal. Base"; Rec."Add.-Curr. Rem. Unreal. Base")
                {
                    ApplicationArea = All;
                    Editable = true;
                }
                field("Add.-Curr. VAT Difference"; Rec."Add.-Curr. VAT Difference")
                {
                    ApplicationArea = All;
                    Editable = true;
                }
                field("Add.-Currency Unrealized Amt."; Rec."Add.-Currency Unrealized Amt.")
                {
                    ApplicationArea = All;
                    Editable = true;
                }
                field("Add.-Currency Unrealized Base"; Rec."Add.-Currency Unrealized Base")
                {
                    ApplicationArea = All;
                    Editable = true;
                }
                field("Additional-Currency Amount"; Rec."Additional-Currency Amount")
                {
                    ApplicationArea = All;
                    Editable = true;
                }
                field("Additional-Currency Base"; Rec."Additional-Currency Base")
                {
                    ApplicationArea = All;
                    Editable = true;
                }
                field("Amount (FCY)"; Rec."Amount (FCY)")
                {
                    ApplicationArea = All;
                    Editable = true;
                }
                field("Base (FCY)"; Rec."Base (FCY)")
                {
                    ApplicationArea = All;
                    Editable = true;
                }
                field("Base Before Pmt. Disc."; Rec."Base Before Pmt. Disc.")
                {
                    ApplicationArea = All;
                    Editable = true;
                }
                field("Bill-to/Pay-to No."; Rec."Bill-to/Pay-to No.")
                {
                    ApplicationArea = All;
                    Editable = true;
                }
                field("Closed by Entry No."; Rec."Closed by Entry No.")
                {
                    ApplicationArea = All;
                    Editable = true;
                }
                field("Country/Region Code"; Rec."Country/Region Code")
                {
                    ApplicationArea = All;
                    Editable = true;
                }
                field("Currency Code"; Rec."Currency Code")
                {
                    ApplicationArea = All;
                    Editable = true;
                }
                field("Currency Factor"; Rec."Currency Factor")
                {
                    ApplicationArea = All;
                    Editable = true;
                }
                field("Document Date"; Rec."Document Date")
                {
                    ApplicationArea = All;
                    Editable = true;
                }
                field("Document No."; Rec."Document No.")
                {
                    ApplicationArea = All;
                    Editable = true;
                }
                field("Document Type"; Rec."Document Type")
                {
                    ApplicationArea = All;
                    Editable = true;
                }
                field("Entry No."; Rec."Entry No.")
                {
                    ApplicationArea = All;
                    Editable = true;
                }
                field("EU 3-Party Trade"; Rec."EU 3-Party Trade")
                {
                    ApplicationArea = All;
                    Editable = true;
                }
                field("EU Service"; Rec."EU Service")
                {
                    ApplicationArea = All;
                    Editable = true;
                }
                field("Exchange Rate Adjustment"; Rec."Exchange Rate Adjustment")
                {
                    ApplicationArea = All;
                    Editable = true;
                }
                field("External Document No."; Rec."External Document No.")
                {
                    ApplicationArea = All;
                    Editable = true;
                }
                field("Gen. Bus. Posting Group"; Rec."Gen. Bus. Posting Group")
                {
                    ApplicationArea = All;
                    Editable = true;
                }
                field("Gen. Prod. Posting Group"; Rec."Gen. Prod. Posting Group")
                {
                    ApplicationArea = All;
                    Editable = true;
                }
                field("Internal Ref. No."; Rec."Internal Ref. No.")
                {
                    ApplicationArea = All;
                    Editable = true;
                }
                field("No. Series"; Rec."No. Series")
                {
                    ApplicationArea = All;
                    Editable = true;
                }
                field("Posting Date"; Rec."Posting Date")
                {
                    ApplicationArea = All;
                    Editable = true;
                }
                field("Realized Amount"; Rec."Realized Amount")
                {
                    ApplicationArea = All;
                    Editable = true;
                }
                field("Realized Base"; Rec."Realized Base")
                {
                    ApplicationArea = All;
                    Editable = true;
                }
                field("Reason Code"; Rec."Reason Code")
                {
                    ApplicationArea = All;
                    Editable = true;
                }
                field("Remaining Unrealized Amount"; Rec."Remaining Unrealized Amount")
                {
                    ApplicationArea = All;
                    Editable = true;
                }
                field("Remaining Unrealized Base"; Rec."Remaining Unrealized Base")
                {
                    ApplicationArea = All;
                    Editable = true;
                }
                field("Reversed by Entry No."; Rec."Reversed by Entry No.")
                {
                    ApplicationArea = All;
                    Editable = true;
                }
                field("Reversed Entry No."; Rec."Reversed Entry No.")
                {
                    ApplicationArea = All;
                    Editable = true;
                }
                field("Sales Tax Connection No."; Rec."Sales Tax Connection No.")
                {
                    ApplicationArea = All;
                    Editable = true;
                }
                field("Ship-to/Order Address Code"; Rec."Ship-to/Order Address Code")
                {
                    ApplicationArea = All;
                    Editable = true;
                }
                field("Source Code"; Rec."Source Code")
                {
                    ApplicationArea = All;
                    Editable = true;
                }
                field("Tax Area Code"; Rec."Tax Area Code")
                {
                    ApplicationArea = All;
                    Editable = true;
                }
                field("Tax Group Code"; Rec."Tax Group Code")
                {
                    ApplicationArea = All;
                    Editable = true;
                }
                field("Tax Group Used"; Rec."Tax Group Used")
                {
                    ApplicationArea = All;
                    Editable = true;
                }
                field("Tax Jurisdiction Code"; Rec."Tax Jurisdiction Code")
                {
                    ApplicationArea = All;
                    Editable = true;
                }
                field("Tax Liable"; Rec."Tax Liable")
                {
                    ApplicationArea = All;
                    Editable = true;
                }
                field("Tax on Tax"; Rec."Tax on Tax")
                {
                    ApplicationArea = All;
                    Editable = true;
                }
                field("Tax Type"; Rec."Tax Type")
                {
                    ApplicationArea = All;
                    Editable = true;
                }
                field("Transaction No."; Rec."Transaction No.")
                {
                    ApplicationArea = All;
                    Editable = true;
                }
                field("Unadjusted Exchange Rate"; Rec."Unadjusted Exchange Rate")
                {
                    ApplicationArea = All;
                    Editable = true;
                }
                field("Unrealized Amount"; Rec."Unrealized Amount")
                {
                    ApplicationArea = All;
                    Editable = true;
                }
                field("Unrealized Base"; Rec."Unrealized Base")
                {
                    ApplicationArea = All;
                    Editable = true;
                }
                field("Unrealized VAT Entry No."; Rec."Unrealized VAT Entry No.")
                {
                    ApplicationArea = All;
                    Editable = true;
                }
                field("Use Tax"; Rec."Use Tax")
                {
                    ApplicationArea = All;
                    Editable = true;
                }
                field("User ID"; Rec."User ID")
                {
                    ApplicationArea = All;
                    Editable = true;
                }
                field("VAT %"; Rec."VAT %")
                {
                    ApplicationArea = All;
                    Editable = true;
                }
                field("VAT Base Discount %"; Rec."VAT Base Discount %")
                {
                    ApplicationArea = All;
                    Editable = true;
                }
                field("VAT Bus. Posting Group"; Rec."VAT Bus. Posting Group")
                {
                    ApplicationArea = All;
                    Editable = true;
                }
                field("VAT Calculation Type"; Rec."VAT Calculation Type")
                {
                    ApplicationArea = All;
                    Editable = true;
                }
                field("VAT Difference"; Rec."VAT Difference")
                {
                    ApplicationArea = All;
                    Editable = true;
                }
                field("VAT Prod. Posting Group"; Rec."VAT Prod. Posting Group")
                {
                    ApplicationArea = All;
                    Editable = true;
                }
                field("VAT Registration No."; Rec."VAT Registration No.")
                {
                    ApplicationArea = All;
                    Editable = true;
                }
                field(Amount; Rec.Amount)
                {
                    ApplicationArea = All;
                    Editable = true;
                }
                field(Base; Rec.Base)
                {
                    ApplicationArea = All;
                    Editable = true;
                }
                field(Closed; Rec.Closed)
                {
                    ApplicationArea = All;
                    Editable = true;
                }
                field(Reversed; Rec.Reversed)
                {
                    ApplicationArea = All;
                    Editable = true;
                }
                field(Type; Rec.Type)
                {
                    ApplicationArea = All;
                    Editable = true;
                }
            }
        }
    }

}
