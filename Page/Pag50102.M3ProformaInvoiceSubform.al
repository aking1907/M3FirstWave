page 50102 "M3 Proforma Invoice Subform"
{

    Caption = 'Proforma Invoice Subform';
    PageType = ListPart;
    SourceTable = "Lot No. Information";

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("External Document No."; Rec."External Document No.")
                {
                    Editable = false;
                    Caption = 'Purch. Invoice No.';
                    ApplicationArea = All;
                    DrillDown = true;

                    trigger OnDrillDown()
                    var
                        PIH: Record "Purch. Inv. Header";
                        PurchInvPage: Page "Posted Purchase Invoice";
                    begin
                        if PIH.Get(Rec."External Document No.") then begin
                            PIH.SetRange("No.", Rec."External Document No.");
                            PurchInvPage.SetRecord(PIH);
                            PurchInvPage.SetTableView(PIH);
                            PurchInvPage.Run;
                        end;

                    end;
                }
                field("Container No."; Rec."Container No.")
                {
                    ApplicationArea = All;
                }
                field("Lot No."; Rec."Lot No.")
                {
                    ApplicationArea = All;
                    Editable = false;
                    DrillDown = true;

                    trigger OnDrillDown()
                    var
                        LOT: Record "Lot No. Information";
                        LotPage: Page "Lot No. Information Card";
                    begin
                        if LOT.Get(Rec."Item No.", Rec."Variant Code", Rec."Lot No.") then begin
                            LOT.SetRange("Lot No.", Rec."Lot No.");
                            LotPage.SetRecord(LOT);
                            LotPage.SetTableView(LOT);
                            LotPage.Run;
                        end;
                    end;
                }
                field("Item No."; Rec."Item No.")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Item Desc"; Rec."Item Desc")
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
                field("Currency Code"; Rec."Currency Code")
                {
                    ApplicationArea = All;
                }
                field("Pure Content, %"; Rec."Pure Content, %")
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
                field(Origin; Rec.Origin)
                {
                    ApplicationArea = All;
                }
                field(Size; Rec.Size)
                {
                    ApplicationArea = All;
                }
                field(Subtotal; Rec.Subtotal)
                {
                    ApplicationArea = All;
                }
            }
        }
    }

    trigger OnInit()
    begin
        Rec.FilterGroup(4);
        Rec.SetFilter("Proforma Invoice No.", '<>%1', '');
        Rec.FilterGroup(0);
    end;
}
