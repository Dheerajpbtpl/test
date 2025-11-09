Report 50013 "Work Performance Report"
{
    Caption = 'Warning Letter';
    RDLCLayout = './Layouts/WorkPerformanceReport.rdlc';
    DefaultLayout = RDLC;

    dataset
    {
        dataitem(Employee; "Employee Master")
        {
            column(No_Employee; Employee.Code)
            {
            }
            column(FirstName_Employee; 'To: ' + Employee."First Name" + ' ' + Employee."Last Name")
            {
            }
            column(JobTitle_Employee; Employee.Designation)
            {
            }
            column(Company_Name; CompanyInformation.Name)
            {
            }
            column(EMail_Employee; 'E-Mail: ' + Employee."Email Id 2")
            {
            }
            column(DateofJoining_Employee; Format(Employee."Date of Joining"))
            {
            }
            column(Salary; Employee.CTC)
            {
            }
            column(Name_Employee; Employee."First Name" + ' ' + Employee."Last Name")
            {
            }
            column(Commenss__1; Comments[1])
            {
            }
            column(Comments_2; Comments[2])
            {
            }
            column(Comments_3; Comments[3])
            {
            }
            column(Comments_4; Comments[4])
            {
            }
            column(Comments_5; Comments[5])
            {
            }
            column(Comments_6; Comments[6])
            {
            }
            column(Comments_7; Comments[7])
            {
            }
            column(Comments_8; Comments[8])
            {
            }
            column(Comments_9; Comments[9])
            {
            }
            column(Comments_10; Comments[10])
            {
            }
            trigger OnAfterGetRecord();
            begin
                int := 0;
                Comment.Reset;
                Comment.SetRange("No.", Employee.Code);
                if Comment.FindFirst then begin
                    repeat
                        int += 1;
                        Comments[int] := Comment.Comment;
                    until Comment.Next = 0;
                end;
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


    trigger OnPreReport()
    begin
        CompanyInformation.Get;
        ;
    end;

    var
        CompanyInformation: Record "Company Information";
        Comment: Record "Comment Line";
        Comments: array[10] of Text;
        int: Integer;

}