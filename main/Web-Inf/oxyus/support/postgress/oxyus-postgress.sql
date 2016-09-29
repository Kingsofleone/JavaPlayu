/*
 * $Id$
 *
 * Copyright 2001 PUCE [http://www.puce.edu.ec]
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *     http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */
 
/*
 * Oxyus database script creation for PostgreSQL
 */

drop sequence seq_ox_server;
drop sequence seq_ox_page;

drop table ox_page cascade;
drop table ox_server cascade;

/* internal oxyus tables */
create table ox_server
(
    code_server       	int             not null,
    protocol		varchar(10)	not null,
    host                varchar(64)	not null,
    port                int             not null,
    constraint pk_server primary key (code_server)
);

create table ox_page
(
    code_page         int               not null,
    code_server       int               not null,
    state             varchar(1)         	not null,
    path              varchar(240)         not null,
    constraint pk_page primary key (code_page),
    constraint fk_page_stored_in_server foreign key  (code_server)
       references ox_server (code_server)
);

/* sequences for primary key generation */
create sequence seq_ox_server;
create sequence seq_ox_page;
