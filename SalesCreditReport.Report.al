Report 50094 "Sales Credit  Report"
{
    UsageCategory = Lists;
    RDLCLayout = './Layouts/SalesCreditReport.rdlc';
    DefaultLayout = RDLC;

    dataset
    {
        dataitem("Sales Cr.Memo Header"; "Sales Cr.Memo Header")
        {
            // CalcFields = "Amount to Customer";
            column(No; "Sales Cr.Memo Header"."No.")
            {
            }
            column(PaymentTermsCode; "Sales Cr.Memo Header"."Payment Terms Code")
            {
            }
            column(DueDate; "Sales Cr.Memo Header"."Due Date")
            {
            }
            column(DocumentDate; "Sales Cr.Memo Header"."Document Date")
            {
            }
            column(Company_Name; CompanyInfo.Name)
            {
            }
            column(Company_Address; CompanyInfo.Address)
            {
            }
            column(Company_City; CompanyInfo.City)
            {
            }
            column(Company_Phone_No; CompanyInfo."Phone No.")
            {
            }
            column(Company_PostCode; CompanyInfo."Post Code")
            {
            }
            column(Company_Email; CompanyInfo."E-Mail")
            {
            }
            column(Comany_Picture; CompanyInfo.Picture)
            {
            }
            column(AmounttoCustomer; AmounttoCustomer)
            {
            }
            column(BilltoName; "Sales Cr.Memo Header"."Bill-to Name")
            {
            }
            column(BilltoAddress; "Sales Cr.Memo Header"."Bill-to Address")
            {
            }
            column(BilltoCity; "Sales Cr.Memo Header"."Bill-to City")
            {
            }
            column(BilltoPostCode; "Sales Cr.Memo Header"."Bill-to Post Code")
            {
            }
            column(BilltoContactNo; "Sales Cr.Memo Header"."Bill-to Contact No.")
            {
            }
            column(ShiptoName; "Sales Cr.Memo Header"."Ship-to Name")
            {
            }
            column(ShiptoAddress; "Sales Cr.Memo Header"."Ship-to Address")
            {
            }
            column(ShiptoCity; "Sales Cr.Memo Header"."Ship-to City")
            {
            }
            column(ShiptoPostCode; "Sales Cr.Memo Header"."Ship-to Post Code")
            {
            }
            column(ShiptoContact; "Sales Cr.Memo Header"."Ship-to Contact")
            {
            }
            dataitem("Sales Cr.Memo Line"; "Sales Cr.Memo Line")
            {
                DataItemLink = "Document No." = field("No.");
                column(Quantity; "Sales Cr.Memo Line".Quantity)
                {
                }
                column(Description; "Sales Cr.Memo Line".Description)
                {
                }
                column(DirectUnitCost; "Sales Cr.Memo Line"."Unit Cost")
                {
                }
                column(LineDiscount; "Sales Cr.Memo Line"."Line Discount Amount")
                {
                }
                column(GST; GstRate)
                {
                }
                column(LineAmount; "Sales Cr.Memo Line"."Line Amount")
                {
                }
                trigger OnAfterGetRecord()
                var
                    myInt: Integer;
                begin
                    Clear(CGSTPer);
                    Clear(SGSTPer);
                    Clear(IGSTPer);
                    Clear(GstRate);
                    DetailGSTLedEnrty.Reset();
                    DetailGSTLedEnrty.SetRange("Document No.", "Sales Cr.Memo Line"."Document No.");
                    DetailGSTLedEnrty.SetRange("Document Line No.", "Sales Cr.Memo Line"."Line No.");
                    DetailGSTLedEnrty.SetRange("Transaction Type", DetailGSTLedEnrty."Transaction Type"::Purchase);
                    DetailGSTLedEnrty.CALCSUMS(DetailGSTLedEnrty."GST Amount");
                    if DetailGSTLedEnrty.FindFirst then begin
                        repeat
                            if DetailGSTLedEnrty."GST Component Code" = 'CGST' then begin
                                CGSTPer := DetailGSTLedEnrty."GST %";
                            end;
                            if DetailGSTLedEnrty."GST Component Code" = 'SGST' then begin
                                SGSTPer := DetailGSTLedEnrty."GST %";
                            end;
                            if DetailGSTLedEnrty."GST Component Code" = 'IGST' then begin
                                IGSTPer := DetailGSTLedEnrty."GST %";
                            end;
                            GstRate := CGSTper + SGSTper + IGSTper;
                        until DetailGSTLedEnrty.Next = 0;
                    end;
                end;
            }
            trigger OnAfterGetRecord()
            var
                myInt: Integer;
            begin
                AmounttoCustomer := 0;
                CustLedEntry.Reset();
                CustLedEntry.SetRange("Document No.", "Sales Cr.Memo Header"."No.");
                CustLedEntry.CalcFields(Amount);
                AmounttoCustomer := CustLedEntry.amount;
            end;
        }
    }

    requestpage
    {


        SaveValues = false;
        layout
        {
            area(content)
            {
                group(Options)
                {
                    Caption = 'Options';

                }
            }
        }

        actions
        {
        }
    }

    trigger OnInitReport()
    begin
        CompanyInfo.Get;
        CompanyInfo.CalcFields(Picture);


    end;



    var
        GstRate: Decimal;
        IGSTPer: Decimal;
        SGSTPer: Decimal;
        CGSTPer: Decimal;
        DetailGSTLedEnrty: Record "Detailed GST Ledger Entry";
        CustLedEntry: Record "Cust. Ledger Entry";
        AmounttoCustomer: Decimal;
        CompanyInfo: Record "Company Information";

}