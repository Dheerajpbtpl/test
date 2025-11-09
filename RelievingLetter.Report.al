Report 50115 "Relieving Letter"
{
    RDLCLayout = './Layouts/RelievingLetter.rdlc';
    DefaultLayout = RDLC;

    dataset
    {
        dataitem(Employee; "Employee Master")
        {
            RequestFilterFields = "Code";
            column(Employee_Name; Employee."First Name" + ' ' + Employee."Last Name")
            {
            }
            column(DateofJoining_Employee; Employee."Date of Joining")
            {
            }
            column(StateName_Employee; Employee."State Name")
            {
            }
            column(CopmyNAme; CompanyInfo.Name)
            {
            }
            column(ResignDate_Employee; Employee."Resign Date")
            {
            }
            column(Designation_Employee; DesignationName)
            {
            }
            column(LeavingDate_Employee; Employee."Leaving Date")
            {
            }
            column(Type_Employee; Employee.Type)
            {
            }
            trigger OnAfterGetRecord();
            begin
                Clear(DesignationName);
                EmpDesignationpb.Reset;
                EmpDesignationpb.SetRange(Code, Employee.Designation);
                if EmpDesignationpb.FindFirst then
                    DesignationName := EmpDesignationpb.Name;
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
        CompanyInfo.Get();
        ;


    end;


    var
        CompanyInfo: Record "Company Information";
        DesignationName: Text;
        EmpDesignationpb: Record "Emp Designation-pb";

}