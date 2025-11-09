/// <summary>
/// Report Dimension Item Report (ID 50004).
/// </summary>
Report 50004 "Dimension Item Report"
{
    UsageCategory = ReportsAndAnalysis;
    RDLCLayout = './Layouts/DimensionItemReport.rdlc';
    DefaultLayout = RDLC;

    dataset
    {
        dataitem("Company Information"; "Company Information")
        {
            column(Name_CompanyInformation; "Company Information".Name)
            {
            }
            column(Address_CompanyInformation; "Company Information".Address)
            {
            }
            column(City_CompanyInformation; "Company Information".City)
            {
            }
            column(PhoneNo_CompanyInformation; "Company Information"."Phone No.")
            {
            }
            column(Picture_CompanyInformation; "Company Information".Picture)
            {
            }
        }
        dataitem("Dimension Value"; "Dimension Value")
        {
            DataItemTableView = where("Dimension Code" = filter('PRODUCT'));
            column(DimensionCode_DimensionValue; "Dimension Value"."Dimension Code")
            {
            }
            column(Code_DimensionValue; "Dimension Value".Code)
            {
            }
            column(Name_DimensionValue; "Dimension Value".Name)
            {
            }
            dataitem("Item Ledger Entry"; "Item Ledger Entry")
            {
                DataItemLink = "Global Dimension 2 Code" = field(Code);
                DataItemTableView = where("Entry Type" = filter(Sale));
                column(InvoicedQuantity_ItemLedgerEntry; "Item Ledger Entry"."Invoiced Quantity")
                {
                }
                column(CostAmountActual_ItemLedgerEntry; "Item Ledger Entry"."Cost Amount (Actual)")
                {
                }
                column(SalesAmountActual_ItemLedgerEntry; "Item Ledger Entry"."Sales Amount (Actual)")
                {
                }
                column(Entry_Type; "Item Ledger Entry"."Entry Type")
                {
                }
                trigger OnAfterGetRecord();
                begin
                    if "Item Ledger Entry"."Invoiced Quantity" < 0 then
                        "Item Ledger Entry"."Invoiced Quantity" := "Item Ledger Entry"."Invoiced Quantity" * -1;
                end;

            }
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


}
