table 50100 "M3 Document Attachment"
{
    Caption = 'M3 Document Attachment';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; ID; Integer)
        {
            AutoIncrement = true;
            Caption = 'ID';
            Editable = false;
        }
        field(2; "Table ID"; Integer)
        {
            Caption = 'Table ID';
            //NotBlank = true;
            TableRelation = AllObjWithCaption."Object ID" WHERE("Object Type" = CONST(Table));
        }
        field(3; "Record ID"; RecordId)
        {
            Caption = 'Record ID';
            //NotBlank = true;
            Editable = false;
        }
        field(4; "Attached Date"; DateTime)
        {
            Caption = 'Attached Date';
            Editable = false;
        }
        field(5; "File Name"; Text[250])
        {
            Caption = 'Attachment';
            //NotBlank = true;

            trigger OnValidate()
            begin
                if "File Name" = '' then
                    Error(EmptyFileNameErr);
            end;
        }
        field(6; "File Type"; Option)
        {
            Caption = 'File Type';
            OptionCaption = ' ,Image,PDF,Word,Excel,PowerPoint,Email,XML,Txt,CSV,Other';
            OptionMembers = " ",Image,PDF,Word,Excel,PowerPoint,Email,XML,TXT,CSV,Other;
        }
        field(7; "File Extension"; Text[30])
        {
            Caption = 'File Extension';

            trigger OnValidate()
            begin
                case LowerCase("File Extension") of
                    'jpg', 'jpeg', 'bmp', 'png', 'tiff', 'tif', 'gif':
                        "File Type" := "File Type"::Image;
                    'pdf':
                        "File Type" := "File Type"::PDF;
                    'docx', 'doc':
                        "File Type" := "File Type"::Word;
                    'xlsx', 'xls':
                        "File Type" := "File Type"::Excel;
                    'pptx', 'ppt':
                        "File Type" := "File Type"::PowerPoint;
                    'msg':
                        "File Type" := "File Type"::Email;
                    'xml':
                        "File Type" := "File Type"::XML;
                    'txt':
                        "File Type" := "File Type"::TXT;
                    'csv':
                        "File Type" := "File Type"::CSV;
                    else
                        "File Type" := "File Type"::Other;
                end;
            end;
        }
        field(8; "Document Reference ID"; BLOB)
        {
            Caption = 'Document Reference ID';
        }
        field(9; "Attached By"; Guid)
        {
            Caption = 'Attached By';
            Editable = false;
            TableRelation = User."User Security ID";
        }
        field(10; User; Code[50])
        {
            CalcFormula = Lookup(User."User Name" WHERE("User Security ID" = FIELD("Attached By"),
                                                         "License Type" = CONST("Full User")));
            Caption = 'User';
            Editable = false;
            FieldClass = FlowField;
        }

    }

    keys
    {
        key(Key1; ID)
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
        fieldgroup(Brick; "File Name", "File Extension", "File Type")
        {
        }
    }

    var
        FileMgt: Codeunit "File Management";
        TempBlob: Codeunit "Temp Blob";
        NoDocumentAttachedErr: Label 'Please attach a document first.';
        EmptyFileNameErr: Label 'Please choose a file to attach.';
        NoContentErr: Label 'The selected file has no content. Please choose another file.';
        FileManagement: Codeunit "File Management";
        IncomingFileName: Text;
        DuplicateErr: Label 'This file is already attached to the document. Please choose another file.';

    trigger OnInsert()
    var
        RecRef: RecordRef;
    begin
        if not "Document Reference ID".HasValue then
            Error(NoDocumentAttachedErr);

        RecRef.Get("Record ID");
        Validate("Table ID", RecRef.Number);
        Validate("Attached Date", CurrentDateTime);
        "Attached By" := UserSecurityId();
    end;

    procedure ImportFileToBLOB(RecID: RecordId)
    var
        FileName: Text;
        DocInStream: InStream;
        DocOutStream: OutStream;
        InputRecordID: RecordId;
        RecRef: RecordRef;
    begin
        if RecRef.Get(RecID) then begin
            "Record ID" := RecID;
            "Table ID" := RecRef.Number;
        end;

        FileName := FileMgt.BLOBImport(TempBlob, 'File');
        if FileName = '' then
            exit;

        "File Name" := FileName;
        Validate("File Extension", FileMgt.GetExtension(FileName));
        TempBlob.CreateInStream(DocInStream, TextEncoding::UTF8);
        "Document Reference ID".CreateOutStream(DocOutStream, TextEncoding::UTF8);
        CopyStream(DocOutStream, DocInStream);

        if not Insert(true) then
            Modify(true);
    end;

    procedure ExportBlobToFile()
    var
        DocInStream: InStream;
        DocOutStream: OutStream;
    begin
        "Document Reference ID".CreateInStream(DocInStream, TextEncoding::UTF8);
        TempBlob.CreateOutStream(DocOutStream, TextEncoding::UTF8);
        CopyStream(DocOutStream, DocInStream);
        FileMgt.BLOBExport(TempBlob, "File Name", true);
    end;

    procedure RefreshRecord(var RecID: RecordId)
    var
        DocID: Integer;
        FGroup: Integer;
    begin
        DocID := ID;
        FGroup := FilterGroup;
        FilterGroup(4);
        SetRange("Record ID", RecID);
        FilterGroup(FGroup);
        if FindSet() then;
        if Get(DocID) then;
    end;
}

