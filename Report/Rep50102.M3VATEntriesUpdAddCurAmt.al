report 50102 "M3 VAT Entries UpdAddCur Amt"
{
    Caption = 'Update VAT Entries Add. Cur. Amount';
    DefaultLayout = RDLC;
    RDLCLayout = './Report/Rep50102.M3VATEntriesUpdAddCurAmt.rdl';
    Permissions = TableData "VAT Entry" = rim;
    PreviewMode = PrintLayout;

    dataset
    {
        dataitem(VATEntry; "VAT Entry")
        {
            column(Entry_No_; "Entry No.")
            {

            }
            column(Document_No_; "Document No.")
            { }
            column(Document_Date; "Document Date")
            { }
            column(Base; Base)
            {
            }
            column(AdditionalCurrencyBase; "Additional-Currency Base")
            {
            }
            column(Amount; Amount)
            {
            }
            column(AdditionalCurrencyAmount; "Additional-Currency Amount")
            {
            }
            column(GLEAddCurAmount; GLEAddCurAmount)
            {

            }
            column(GLEVATAmount; GLEVATAmount)
            {

            }

            trigger OnAfterGetRecord()
            var
                GLEntry: Record "G/L Entry";
                GLAccount: Record "G/L Account";
            begin
                GLEAddCurAmount := 0;
                GLEVATAmount := 0;

                GLEntry.SetRange("Document No.", VATEntry."Document No.");
                GLEntry.SetRange("Posting Date", VATEntry."Posting Date");
                GLEntry.SetRange(Amount, VATEntry.Base);
                if GLEntry.FindFirst() then begin
                    GLEAddCurAmount := GLEntry."Additional-Currency Amount";

                    if IsUpdateAmount then begin
                        VATEntry."Additional-Currency Base" := GLEntry."Additional-Currency Amount";
                        VATEntry.Modify();
                    end;

                    if VATEntry.Amount <> 0 then begin
                        GLEntry.SetRange(Amount, VATEntry.Amount);
                        if GLEntry.FindFirst() then begin
                            GLEVATAmount := GLEntry."Additional-Currency Amount";

                            if IsUpdateAmount then begin
                                VATEntry."Additional-Currency Amount" := GLEntry."Additional-Currency Amount";
                                VATEntry.Modify();
                            end;
                        end;
                    end;
                end;
            end;
        }
    }
    requestpage
    {
        layout
        {
            area(content)
            {
                group(Options)
                {
                    Caption = 'Options';
                    field(IsUpdateAmount; IsUpdateAmount)
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Update Add. Cur. Amount';
                    }
                }
            }
        }
        actions
        {
            area(processing)
            {
            }
        }
    }

    var
        GLEAddCurAmount: Decimal;
        GLEVATAmount: Decimal;
        IsUpdateAmount: Boolean;

}
