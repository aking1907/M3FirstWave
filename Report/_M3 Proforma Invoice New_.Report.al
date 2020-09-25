report 50100 "M3 Proforma Invoice New"
{
    DefaultLayout = RDLC;
    Caption = 'Proforma Invoice Printout';
    PreviewMode = PrintLayout;
    ApplicationArea = All;
    UsageCategory = Lists;

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
            dataitem(ReportBodyTbl; ReportBody)
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
                column(ProformaDate; Format("Document Date", 0, '<Day,2>.<Month,2>.<Year4>'))
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
                column(DeliveryBasisDesc; "Delivery Basis Desc")
                {
                }
                column(DocumentBasis; "Delivery Basis")
                {
                }
                dataitem(LotNoInfo; "Lot No. Information")
                {
                    DataItemLink = "Proforma Invoice No." = field("No.");
                    DataItemLinkReference = ProfInvHeader;
                    column(ItemDesc; "Item Desc")
                    {
                    }
                    column(ItemNetWeight; "Weight Net")
                    {
                    }
                    column(ItemGrossWeight; "Weight Gross")
                    {
                    }
                    column(ItemPrice; "Price Net")
                    {
                    }
                    column(LineAmount; Subtotal)
                    {
                    }
                    column(ContainerName; "Container No.")
                    {
                    }
                    column(CurrencyCode; "Currency Code")
                    {
                    }
                }
            }
            trigger OnPreDataItem()
            begin
                ContainersDesc := GetListOfContainers();
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
        //records
        CompanyInfo: Record "Company Information";
        GLSetup: Record "General Ledger Setup";
        Country: Record "Country/Region";
        
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
}
