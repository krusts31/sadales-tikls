REPLACE INTO mailserver.virtual_domains (id,name) VALUES ('1','{{ .Env.DOMAIN }}');

-- user 

REPLACE INTO mailserver.virtual_users (id,domain_id,password,email)
VALUES ('1', '1', '{{ .Env.EMAIL_USER_PASSWORD }}', '{{ .Env.EMAIL_USER }}@{{ .Env.DOMAIN }}');

REPLACE INTO mailserver.virtual_aliases (id,domain_id,source,destination)
VALUES ('1', '1', '{{ .Env.EMAIL_USER }}@{{ .Env.DOMAIN }}', '{{ .Env.EMAIL_USER }}@{{ .Env.DOMAIN }}');

-- forensics

REPLACE INTO mailserver.virtual_users (id, domain_id, password, email)
VALUES ('3', '1', '{{ .Env.EMAIL_FORENSICS_PASSWORD }}', '{{ .Env.EMAIL_FORENSICS }}@{{ .Env.DOMAIN }}');

REPLACE INTO mailserver.virtual_aliases (id, domain_id, source, destination)
VALUES ('3', '1', '{{ .Env.EMAIL_FORENSICS }}@{{ .Env.DOMAIN }}', '{{ .Env.EMAIL_FORENSICS }}@{{ .Env.DOMAIN }}');

-- reports

REPLACE INTO mailserver.virtual_users (id, domain_id, password, email)
VALUES ('2', '1', '{{ .Env.EMAIL_REPORTS_PASSWORD }}', '{{ .Env.EMAIL_REPORTS }}@{{ .Env.DOMAIN }}');

REPLACE INTO mailserver.virtual_aliases (id, domain_id, source, destination)
VALUES ('2', '1', '{{ .Env.EMAIL_REPORTS }}@{{ .Env.DOMAIN }}', '{{ .Env.EMAIL_REPORTS }}@{{ .Env.DOMAIN }}');

-- postmaster

REPLACE INTO mailserver.virtual_users (id, domain_id, password, email)
VALUES ('4', '1', '{{ .Env.EMAIL_POSTMASTER_PASSWORD }}', '{{ .Env.EMAIL_POSTMASTER }}@{{ .Env.DOMAIN }}');

REPLACE INTO mailserver.virtual_aliases (id, domain_id, source, destination)
VALUES ('4', '1', '{{ .Env.EMAIL_POSTMASTER }}@{{ .Env.DOMAIN }}', '{{ .Env.EMAIL_POSTMASTER }}@{{ .Env.DOMAIN }}');

-- robot

REPLACE INTO mailserver.virtual_users (id, domain_id, password, email)
VALUES ('5', '1', '{{ .Env.EMAIL_BOT_PASSWORD }}', '{{ .Env.EMAIL_BOT }}@{{ .Env.DOMAIN }}');

REPLACE INTO mailserver.virtual_aliases (id, domain_id, source, destination)
VALUES ('5', '1', '{{ .Env.EMAIL_BOT }}@{{ .Env.DOMAIN }}', '{{ .Env.EMAIL_BOT }}@{{ .Env.DOMAIN }}');


-- rejectedorders

REPLACE INTO mailserver.virtual_users (id, domain_id, password, email)
VALUES ('6', '1', '{{ .Env.EMAIL_REJECTEDORDERS_PASSWORD }}', '{{ .Env.EMAIL_REJECTEDORDERS }}@{{ .Env.DOMAIN }}');

REPLACE INTO mailserver.virtual_aliases (id, domain_id, source, destination)
VALUES ('6', '1', '{{ .Env.EMAIL_REJECTEDORDERS }}@{{ .Env.DOMAIN }}', '{{ .Env.EMAIL_REJECTEDORDERS }}@{{ .Env.DOMAIN }}');

-- complaints

REPLACE INTO mailserver.virtual_users (id, domain_id, password, email)
VALUES ('7', '1', '{{ .Env.EMAIL_COMPLAINTS_PASSWORD }}', '{{ .Env.EMAIL_COMPLAINTS }}@{{ .Env.DOMAIN }}');

REPLACE INTO mailserver.virtual_aliases (id, domain_id, source, destination)
VALUES ('7', '1', '{{ .Env.EMAIL_COMPLAINTS }}@{{ .Env.DOMAIN }}', '{{ .Env.EMAIL_COMPLAINTS }}@{{ .Env.DOMAIN }}');
