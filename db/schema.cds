namespace riskmanagement;

using {
        managed,
        cuid,
        sap.common.CodeList
} from '@sap/cds/common';

entity Risks : cuid, managed {
        title                   : String(100);
        owner                   : String;
        prio                    : Association to Priority;
        descr                   : String;
        miti                    : Association to Mitigations;
        impact                  : Integer;
        changeLog               : Composition of many ChangeLog
                                        on changeLog.risk = $self;
        // bp : Association to BusinessPartners;
        virtual criticality     : Integer;
        virtual PrioCriticality : Integer;
}

entity Mitigations : cuid, managed {
        descr    : String;
        owner    : String;
        timeline : String;
        risks    : Association to many Risks
                           on risks.miti = $self;
}

entity Priority : CodeList {
        key code : String enum {
                    high   = 'H';
                    medium = 'M';
                    low    = 'L';
            };
}

entity ChangeLog : cuid, managed {
        property  : String;
        prevValue : String;
        newValue  : String;
        risk      : Association to Risks;
}

@readonly
entity ListOfRisks as
        select from riskmanagement.Risks as risks {
                risks.ID,
                risks.title,
                risks.descr,
        }

// new wntity for learning purpose, not included into main lessons

entity Items : cuid {
        title: String;
        descr: String;
        quantity: Integer;
}