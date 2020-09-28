report 50100 "M3 Proforma Invoice"
{
    DefaultLayout = RDLC;
    RDLCLayout = './Report/ProformaInvoice.rdl';
    Caption = 'Proforma Invoice';
    PreviewMode = PrintLayout;

    dataset
    {
        dataitem(CopyLoop; "Integer")
        {
            DataItemTableView = SORTING(Number) WHERE(Number = CONST(1));

            column(Logo; CompanyInfo.Picture)
            {
            }
            column(Address;
            CompanyInfo.Address)
            {
            }
            column("Address2"; CompanyInfo."Address 2")
            {
            }
            column(ShortAddress; ShortAddress)
            {
            }
            column(CountryName; Country.Name)
            {
            }
            column(Phone; CompanyInfo."Phone No.")
            {
            }
            column(PhoneLbl; PhoneLbl)
            {
            }
            column(Fax; CompanyInfo."Fax No.")
            {
            }
            column(FaxLbl; FaxLbl)
            {
            }
            column(Email; CompanyInfo."E-Mail")
            {
            }
            column(EmailLbl; EmailLbl)
            {
            }
            column(HomePage; CompanyInfo."Home Page")
            {
            }
            column(HttpLbl; HttpLbl)
            {
            }
            column(VATNo; CompanyInfo."VAT Registration No.")
            {
            }
            column(VATNoLbl; VATNoLbl)
            {
            }
            column(TotalAmpountText; TotalAmountText)
            {
            }
            dataitem(ProfInvHeader; "M3 Proforma Invoice Header")
            {
                DataItemTableView = SORTING("No.");
                column(ProformaNo; "No.")
                {
                }
                column(ProformaInvoiceNoLbl; ProformaInvoiceNoLbl)
                {
                }
                column(ProformaDate; StrSubstNo('%1%2', DateLbl, format("Document Date", 0, '<Day,2>.<Month,2>.<Year4>')))
                {
                }
                column(DateLbl; DateLbl)
                {
                }
                column(ShipperLbl; ShipperLbl)
                {
                }
                column(ShipperDesc; "Shipper Desc")
                {
                }
                column(ProducerLbl; ProducerLbl)
                {
                }
                column(ProducerDesc; "Producer Desc")
                {
                }
                column(ConsigneeLbl; ConsigneeLbl)
                {
                }
                column(ConsigneeDesc; "Consignee Desc")
                {
                }
                column(LoadingPointLbl; LoadingPointLbl)
                {
                }
                column(LoadingPointDesc; "Loading Point Desc")
                {
                }
                column(ContainersLbl; ContainersLbl)
                {
                }
                column(ContainersDesc; ContainersDesc)
                {
                }
                column(DeliveryPointLbl; DeliveryPointLbl)
                {
                }
                column(DeliveryPointDesc; "Delivery Point Desc")
                {
                }
                column(DeliveryBasisLbl; DeliveryBasisLbl)
                {
                }
                column(DeliveryBasisDesc; "Delivery Basis")
                {
                }
                column(DocumentBasis; "Delivery Basis Desc")
                {
                }
                dataitem(LotNoInfo; "Lot No. Information")
                {
                    DataItemLink = "Proforma Invoice No." = field("No.");
                    DataItemLinkReference = ProfInvHeader;
                    column(ItemDesc; "Item Desc")
                    {
                    }
                    column(ContainerLbl; ContainerLbl)
                    {
                    }
                    column(ContainerName; "Container No.")
                    {
                    }
                    column(PureContentLbl; PureContentLbl)
                    {

                    }
                    column(PureContent; format("Pure Content, %") + '%')
                    {

                    }
                    column(PriceLbl; PriceLbl)
                    {

                    }
                    column(PriceGross; StrSubstNo('%1 %2', "Price Gross", "Currency Code"))
                    {

                    }
                    column(PriceContentLbl; PriceContentLbl)
                    {

                    }
                    column(PriceNet; StrSubstNo('%1 %2', "Price Net", "Currency Code"))
                    {

                    }
                    column(WeightNetLbl; WeightNetLbl)
                    {

                    }
                    column(NetWeight; "Weight Net")
                    {
                    }
                    column(WeightGrossLbl; WeightGrossLbl)
                    {

                    }
                    column(GrossWeight; "Weight Gross")
                    {
                    }
                    column(OriginLbl; OriginLbl)
                    {

                    }
                    column(Origin; Origin)
                    {

                    }
                    column(SubtotalLbl; SubtotalLbl)
                    {

                    }
                    column(Subtotal; StrSubstNo('%1 %2', Subtotal, "Currency Code"))
                    {
                    }
                }
            }
            trigger OnPreDataItem()
            begin
                ContainersDesc := GetListOfContainers();
                Error(FormatTotalAmountText());
            end;
        }
    }
    requestpage
    {
        layout
        {
            area(content)
            {
                group(GroupName)
                {
                    Caption = 'Options';

                    // field(NoOfCopies; NoOfCopies)
                    // {
                    //     ApplicationArea = Suite;
                    //     Caption = 'No. of Copies';
                    // }
                    field(ProformaNo; ProformaNo)
                    {
                        ApplicationArea = Suite;
                        Caption = 'Proforma No.';
                    }
                    field(PurchaseInvoiceNo; PurchaseInvoiceNo)
                    {
                        ApplicationArea = Suite;
                        Caption = 'Purchase Invoice No.';
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
        NoOfCopies: Integer;
        ProformaNo: Code[20];
        PurchaseInvoiceNo: Code[20];
        ShortAddress: Text[100];
        ContainersDesc: Text[250];
        TotalAmount: Decimal;
        TotalAmountText: Text[150];
        OnesText: Array[20] of Text[30];
        TensText: Array[10] of Text[30];
        ThousText: array[5] of Text[30];
        //records
        CompanyInfo: Record "Company Information";
        GLSetup: Record "General Ledger Setup";
        Country: Record "Country/Region";
        ReportCheck: Report Check;

        //lables
        PhoneLbl: Label 'Phone';
        FaxLbl: Label 'Fax';
        EmailLbl: Label 'E-mail';
        HttpLbl: Label 'Http';
        VATNoLbl: Label 'VAT №';
        ProformaInvoiceNoLbl: Label 'PROFORMA INVOICE №';
        DateLbl: Label 'Date:';
        ShipperLbl: Label 'Shipper:';
        ProducerLbl: Label 'Producer:';
        ConsigneeLbl: Label 'Consignee:';
        LoadingPointLbl: Label 'Loading point:';
        ContainersLbl: Label 'Containers:';
        DeliveryPointLbl: Label 'Delivery point:';
        DeliveryBasisLbl: Label 'Delivery basis:';
        ContainerLbl: label 'Container:';
        PureContentLbl: Label 'Pure content:';
        PriceLbl: Label 'Price:';
        PriceContentLbl: Label 'Content price:';
        WeightNetLbl: Label 'Weight net:';
        WeightGrossLbl: Label 'Weight gross:';
        SizeLbl: Label 'Size';
        OriginLbl: Label 'Origin:';
        SubtotalLbl: Label 'Subtotal';
        ErrInputData: Label 'Error input data!';

    trigger OnInitReport()
    begin
        GLSetup.Get();
        CompanyInfo.Get();
        CompanyInfo.CalcFields(Picture);
        Country.Get(CompanyInfo."Country/Region Code");
        ShortAddress := StrSubstNo('%1-%2 %3', CompanyInfo."Country/Region Code", CompanyInfo."Post Code", CompanyInfo.City);
        ProformaNo := 'PI00000005';
    end;

    trigger OnPreReport()
    begin
        CopyLoop.SetRange(Number, 1);
    end;

    local procedure GetListOfContainers(): Text
    var
        ListOfContainers: Text;
        Lot: Record "Lot No. Information";
    begin
        Lot.SetRange("Proforma Invoice No.", ProformaNo);
        if Lot.FindSet() then
            repeat
                ListOfContainers += Lot."Container No." + ',';
            until Lot.Next() = 0;
        exit(DelChr(ListOfContainers, '<>', ','));
    end;

    procedure InitData(PurchInvHeaderNo: Code[20]; ProformaInvNo: Code[20])
    begin
        ProformaNo := ProformaInvNo;
        PurchaseInvoiceNo := PurchInvHeaderNo;
        NoOfCopies := 1;
    end;

    local procedure FormatTotalAmountText(): Text[150]
    var
        Lot: Record "Lot No. Information";
        PIH: Record "Purch. Inv. Header";
        CurrencyCode: Code[5];
        TextArray: Array[2] of Text[80];
    begin
        Lot.SetRange("Proforma Invoice No.", ProformaNo);
        if Lot.IsEmpty then exit('');
        if Lot.FindSet() then
            repeat
                if PIH.Get(Lot."Certificate Number") then begin
                    PIH.CalcFields("Amount Including VAT");
                    TotalAmount += PIH."Amount Including VAT";
                    CurrencyCode := pih."Currency Code";
                end;
            until Lot.Next() = 0;

        InitTextVariables;
        Error(StrSubstNo('%1 and %2',
                NumberToWords(round(TotalAmount, 1, '<'), 'dollars'),
                NumberToWords(round(TotalAmount * 100, 1, '<') mod 100, 'cents')
            ));

    end;

    procedure NumberToWords(number: Integer; appendScale: Text): Text
    var
        numString: Text;
        pow: Integer;
        powStr: Text;
        log: Integer;
    begin
        numString := '';
        if number < 100 then
            if number < 20 then
                numString := OnesText[number]
            ELSE BEGIN
                numString := TensText[number DIV 10];
                if (number MOD 10) > 0 then
                    numString := numString + ' ' + OnesText[number MOD 10];
            END
        ELSE BEGIN
            pow := 0;
            powStr := '';
            if number < 1000 then begin // number is between 100 and 1000
                pow := 100;
                powStr := ThousText[1];
            END ELSE begin // find the scale of the number
                log := number DIV 1000;
                pow := POWER(1000, log);
                powStr := ThousText[log + 1];
            END;

            numString := NumberToWords(number DIV pow, powStr) + ' ' + NumberToWords(number MOD pow, '');
        END;

        EXIT(numString + ' ' + appendScale);
    end;

    local procedure InitTextVariables()
    begin
        OnesText[1] := 'one';
        OnesText[2] := 'two';
        OnesText[3] := 'three';
        OnesText[4] := 'four';
        OnesText[5] := 'five';
        OnesText[6] := 'six';
        OnesText[7] := 'seven';
        OnesText[8] := 'eight';
        OnesText[9] := 'nine';
        OnesText[10] := 'ten';
        OnesText[11] := 'eleven';
        OnesText[12] := 'twelve';
        OnesText[13] := 'thirteen';
        OnesText[14] := 'fourteen';
        OnesText[15] := 'fifteen';
        OnesText[16] := 'sixteen';
        OnesText[17] := 'seventeen';
        OnesText[18] := 'eighteen';
        OnesText[19] := 'nineteen';

        TensText[1] := '';
        TensText[2] := 'twenty';
        TensText[3] := 'thirty';
        TensText[4] := 'forty';
        TensText[5] := 'fivty';
        TensText[6] := 'sixty';
        TensText[7] := 'seventy';
        TensText[8] := 'eighty';
        TensText[9] := 'ninty';

        ThousText[1] := 'hundred';
        ThousText[2] := 'thousand';
        ThousText[3] := 'million';
        ThousText[4] := 'billion';
        ThousText[5] := 'trillion';
    end;
}
