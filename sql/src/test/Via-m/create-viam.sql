START TRANSACTION;
CREATE SEQUENCE "sys"."seq_annotator_id" AS INTEGER;
CREATE SEQUENCE "sys"."seq_event_id" AS INTEGER;
CREATE SEQUENCE "sys"."seq_event_metadata_id" AS INTEGER;
CREATE SEQUENCE "sys"."seq_feature_id" AS INTEGER;
CREATE SEQUENCE "sys"."seq_keyword_id" AS INTEGER;
CREATE SEQUENCE "sys"."seq_media_description_id" AS INTEGER;
CREATE SEQUENCE "sys"."seq_model_sets_name_id" AS INTEGER;
CREATE SEQUENCE "sys"."seq_video_sets_id" AS INTEGER;
CREATE SEQUENCE "sys"."seq_annotation_sets_id" AS INTEGER;
CREATE SEQUENCE "sys"."seq_production_type_id" AS INTEGER;
CREATE SEQUENCE "sys"."seq_media_id" AS INTEGER;
CREATE SEQUENCE "sys"."seq_file_id" AS INTEGER;
CREATE SEQUENCE "sys"."seq_fragment_id" AS INTEGER;
CREATE SEQUENCE "sys"."seq_feature_vector_id" AS INTEGER;
CREATE SEQUENCE "sys"."seq_annotation_id" AS INTEGER;
CREATE SEQUENCE "sys"."seq_frame_image_id" AS INTEGER;
CREATE SEQUENCE "sys"."seq_keyword_sets_id" AS INTEGER;
CREATE SEQUENCE "sys"."seq_keyword_set_id" AS INTEGER;
CREATE SEQUENCE "sys"."seq_model_ref_id" AS INTEGER;
CREATE SEQUENCE "sys"."seq_model_id" AS INTEGER;
CREATE SEQUENCE "sys"."seq_model_sets_id" AS INTEGER;
CREATE SEQUENCE "sys"."seq_model_set_id" AS INTEGER;
CREATE SEQUENCE "sys"."seq_annotation_set_id" AS INTEGER;
CREATE SEQUENCE "sys"."seq_production_id" AS INTEGER;
CREATE SEQUENCE "sys"."seq_score_id" AS INTEGER;
CREATE SEQUENCE "sys"."seq_video_set_id" AS INTEGER;
SET SCHEMA "sys";
CREATE TABLE "sys"."i_bulk_annotation" (
	"keyword_name" varchar(128) NOT NULL,
	"quid" bigint NOT NULL,
	"fragment_start" int NOT NULL,
	"relevance" real NOT NULL,
	"confidence" real NOT NULL,
	"annotation_date" timestamp(7) NOT NULL
);
CREATE TABLE "sys"."i_bulk_feature_vector" (
	"quid" bigint NOT NULL,
	"fragment_start" int NOT NULL,
	"vector" blob NOT NULL
);
CREATE TABLE "sys"."i_bulk_fragment" (
	"quid" bigint NOT NULL,
	"fragment_start" int NOT NULL,
	"fragment_length" int NOT NULL,
	"fragment_name" varchar(64) NOT NULL,
	"keyframe" boolean NOT NULL DEFAULT false,
	"representative" boolean NOT NULL DEFAULT false
);
CREATE TABLE "sys"."i_bulk_frame_image" (
	"quid" bigint NOT NULL,
	"fragment_start" int NOT NULL,
	"fragment_name" varchar(64) NOT NULL,
	"image" blob NOT NULL,
	"width" int,
	"height" int,
	"mime_type" varchar(128)
);
CREATE TABLE "sys"."i_bulk_score" (
	"quid" bigint NOT NULL,
	"fragment_start" int NOT NULL,
	"confidence" real NOT NULL
);
CREATE TABLE "sys"."annotator" (
	"annotator_id" int NOT NULL DEFAULT next value for "sys"."seq_annotator_id",
	"annotator_name" varchar(128) NOT NULL,
	"annotator_type" varchar(64) NOT NULL,
	"approved" boolean NOT NULL DEFAULT false,
	CONSTRAINT "annotator_annotator_id_pkey" PRIMARY KEY ("annotator_id"),
	CONSTRAINT "unq_annotator_name" UNIQUE ("annotator_name")
);
COPY 1 RECORDS INTO "sys"."annotator" FROM stdin USING DELIMITERS '\t';
1	"fabchannel"	"the boss"	true
CREATE TABLE "sys"."event" (
	"event_id" int NOT NULL DEFAULT next value for "sys"."seq_event_id",
	"event_name" varchar(256) NOT NULL,
	"event_date" date NOT NULL,
	"description" varchar(4096),
	CONSTRAINT "event_event_id_pkey" PRIMARY KEY ("event_id"),
	CONSTRAINT "unq_event_name" UNIQUE ("event_name")
);
CREATE TABLE "sys"."event_metadata" (
	"event_metadata_id" int NOT NULL DEFAULT next value for "sys"."seq_event_metadata_id",
	"event_id" int NOT NULL,
	"metadata_name" varchar(64),
	"metadata_value" varchar(256),
	CONSTRAINT "event_metadata_event_metadata_id_pkey" PRIMARY KEY ("event_metadata_id"),
	CONSTRAINT "unq_metadata" UNIQUE ("event_id", "metadata_name", "metadata_value")
);
CREATE TABLE "sys"."feature" (
	"feature_id" int NOT NULL DEFAULT next value for "sys"."seq_feature_id",
	"feature_name" varchar(128) NOT NULL,
	CONSTRAINT "feature_feature_id_pkey" PRIMARY KEY ("feature_id"),
	CONSTRAINT "unq_feature_name" UNIQUE ("feature_name")
);
CREATE TABLE "sys"."keyword" (
	"keyword_id" int NOT NULL DEFAULT next value for "sys"."seq_keyword_id",
	"keyword_name" varchar(128) NOT NULL,
	CONSTRAINT "keyword_keyword_id_pkey" PRIMARY KEY ("keyword_id"),
	CONSTRAINT "unq_keyword_name" UNIQUE ("keyword_name")
);
CREATE TABLE "sys"."media_description" (
	"media_description_id" int NOT NULL DEFAULT next value for "sys"."seq_media_description_id",
	"description" varchar(64) NOT NULL,
	CONSTRAINT "media_description_media_description_id_pkey" PRIMARY KEY ("media_description_id"),
	CONSTRAINT "unq_media_description_description" UNIQUE ("description")
);
COPY 1 RECORDS INTO "sys"."media_description" FROM stdin USING DELIMITERS '\t';
1	"dummy description"
CREATE TABLE "sys"."model_sets_name" (
	"model_sets_name_id" int NOT NULL DEFAULT next value for "sys"."seq_model_sets_name_id",
	"set_name" varchar(128) NOT NULL,
	CONSTRAINT "model_sets_name_model_sets_name_id_pkey" PRIMARY KEY ("model_sets_name_id"),
	CONSTRAINT "unq_model_sets_name_name" UNIQUE ("set_name")
);
CREATE TABLE "sys"."video_sets" (
	"video_sets_id" int NOT NULL DEFAULT next value for "sys"."seq_video_sets_id",
	"identifier" int NOT NULL,
	"set_name" varchar(128) NOT NULL,
	CONSTRAINT "video_sets_video_sets_id_pkey" PRIMARY KEY ("video_sets_id"),
	CONSTRAINT "unq_video_sets_name" UNIQUE ("set_name")
);
CREATE TABLE "sys"."annotation_sets" (
	"annotation_sets_id" int NOT NULL DEFAULT next value for "sys"."seq_annotation_sets_id",
	"set_name" varchar(128) NOT NULL,
	CONSTRAINT "pk_annotation_sets_annotation_sets_id" PRIMARY KEY ("annotation_sets_id"),
	CONSTRAINT "unq_annotation_sets_name" UNIQUE ("set_name")
);
CREATE TABLE "sys"."production_type" (
	"production_type_id" int NOT NULL DEFAULT next value for "sys"."seq_production_type_id",
	"production_steps" varchar(32) NOT NULL,
	CONSTRAINT "production_type_production_type_id_pkey" PRIMARY KEY ("production_type_id"),
	CONSTRAINT "unq_production_type_steps" UNIQUE ("production_steps")
);
COPY 2 RECORDS INTO "sys"."production_type" FROM stdin USING DELIMITERS '\t';
1	"full"
2	"result"
CREATE TABLE "sys"."media" (
	"media_id" int NOT NULL DEFAULT next value for "sys"."seq_media_id",
	"event_id" int NOT NULL,
	"media_description_id" int NOT NULL,
	"identifier" varchar(128) NOT NULL,
	"quid" bigint NOT NULL,
	"preferred" boolean NOT NULL DEFAULT false,
	"frame_rate" real NOT NULL,
	"frame_count" int NOT NULL,
	CONSTRAINT "media_media_id_pkey" PRIMARY KEY ("media_id"),
	CONSTRAINT "unq_media_event" UNIQUE ("event_id", "media_description_id"),
	CONSTRAINT "unq_media_identifier" UNIQUE ("identifier")
);
CREATE TABLE "sys"."file" (
	"file_id" int NOT NULL DEFAULT next value for "sys"."seq_file_id",
	"media_id" int NOT NULL,
	"filename" varchar(256) NOT NULL,
	"codec" varchar(64) NOT NULL,
	"bitrate" varchar(64) NOT NULL,
	"identifier" varchar(64) NOT NULL,
	"quid" bigint NOT NULL,
	"download_url" varchar(256) NOT NULL,
	"account_name" varchar(128) NOT NULL DEFAULT 'empty',
	"width" int,
	"height" int,
	CONSTRAINT "file_file_id_pkey" PRIMARY KEY ("file_id"),
	CONSTRAINT "unq_file_identifier" UNIQUE ("identifier")
);
CREATE TABLE "sys"."fragment" (
	"fragment_id" bigint NOT NULL DEFAULT next value for "sys"."seq_fragment_id",
	"media_id" int NOT NULL,
	"fragment_start" int NOT NULL,
	"fragment_length" int NOT NULL,
	"fragment_name" varchar(64) NOT NULL,
	"keyframe" boolean NOT NULL DEFAULT false,
	"representative" boolean NOT NULL DEFAULT false,
	CONSTRAINT "fragment_fragment_id_pkey" PRIMARY KEY ("fragment_id"),
	CONSTRAINT "unq_fragment_media" UNIQUE ("media_id", "fragment_start", "fragment_length", "keyframe")
);
CREATE TABLE "sys"."feature_vector" (
	"feature_vector_id" bigint NOT NULL DEFAULT next value for "sys"."seq_feature_vector_id",
	"fragment_id" bigint NOT NULL,
	"file_id" int NOT NULL,
	"feature_id" int NOT NULL,
	"vector" blob NOT NULL,
	CONSTRAINT "feature_vector_feature_vector_id_pkey" PRIMARY KEY ("feature_vector_id"),
	CONSTRAINT "unq_feature_vector_fragment" UNIQUE ("fragment_id", "file_id", "feature_id")
);
CREATE TABLE "sys"."annotation" (
	"annotation_id" int NOT NULL DEFAULT next value for "sys"."seq_annotation_id",
	"fragment_id" bigint NOT NULL,
	"keyword_id" int NOT NULL,
	"annotator_id" int NOT NULL,
	"relevance" real NOT NULL,
	"confidence" real NOT NULL,
	"annotation_date" timestamp(7) NOT NULL,
	"approved" boolean NOT NULL DEFAULT false,
	CONSTRAINT "annotation_annotation_id_pkey" PRIMARY KEY ("annotation_id"),
	CONSTRAINT "unq_annotation_fragment" UNIQUE ("fragment_id", "keyword_id", "annotator_id")
);
CREATE TABLE "sys"."frame_image" (
	"frame_image_id" bigint NOT NULL DEFAULT next value for "sys"."seq_frame_image_id",
	"fragment_id" bigint NOT NULL,
	"image" blob NOT NULL,
	"full_size" boolean NOT NULL DEFAULT false,
	"width" int,
	"height" int,
	"mime_type" varchar(128),
	CONSTRAINT "frame_image_frame_image_id_pkey" PRIMARY KEY ("frame_image_id"),
	CONSTRAINT "unq_frame_image_fragment_id" UNIQUE ("fragment_id", "full_size")
);
CREATE TABLE "sys"."keyword_sets" (
	"keyword_sets_id" int NOT NULL DEFAULT next value for "sys"."seq_keyword_sets_id",
	"set_name" varchar(128) NOT NULL,
	"video_sets_id" int NOT NULL,
	CONSTRAINT "keyword_sets_keyword_sets_id_pkey" PRIMARY KEY ("keyword_sets_id"),
	CONSTRAINT "unq_keyword_sets_name" UNIQUE ("set_name", "video_sets_id")
);
CREATE TABLE "sys"."keyword_set" (
	"keyword_set_id" int NOT NULL DEFAULT next value for "sys"."seq_keyword_set_id",
	"keyword_sets_id" int NOT NULL,
	"keyword_id" int NOT NULL,
	CONSTRAINT "keyword_set_keyword_set_id_pkey" PRIMARY KEY ("keyword_set_id"),
	CONSTRAINT "unq_keyword_set_keyword_sets" UNIQUE ("keyword_sets_id", "keyword_id")
);
CREATE TABLE "sys"."model_ref" (
	"model_ref_id" int NOT NULL DEFAULT next value for "sys"."seq_model_ref_id",
	"model_name" varchar(256) NOT NULL,
	"keyword_set_id" int NOT NULL,
	CONSTRAINT "model_ref_model_ref_id_pkey" PRIMARY KEY ("model_ref_id"),
	CONSTRAINT "unq_model_name_keyword_set_id" UNIQUE ("model_name", "keyword_set_id")
);
CREATE TABLE "sys"."model" (
	"model_id" int NOT NULL DEFAULT next value for "sys"."seq_model_id",
	"model_ref_id" int NOT NULL,
	"feature_id" int NOT NULL,
	CONSTRAINT "model_model_id_pkey" PRIMARY KEY ("model_id"),
	CONSTRAINT "unq_model_ref" UNIQUE ("model_ref_id", "feature_id")
);
CREATE TABLE "sys"."model_sets" (
	"model_sets_id" int NOT NULL DEFAULT next value for "sys"."seq_model_sets_id",
	"model_ref_id" int NOT NULL,
	"model_sets_name_id" int NOT NULL,
	CONSTRAINT "model_sets_model_sets_id_pkey" PRIMARY KEY ("model_sets_id"),
	CONSTRAINT "unq_model_sets_name_model_ref" UNIQUE ("model_sets_name_id", "model_ref_id")
);
CREATE TABLE "sys"."model_set" (
	"model_set_id" int NOT NULL DEFAULT next value for "sys"."seq_model_set_id",
	"model_sets_id" int NOT NULL,
	"model_id" int NOT NULL,
	CONSTRAINT "unq_model_set_model_sets" UNIQUE ("model_sets_id", "model_id")
);
CREATE TABLE "sys"."annotation_set" (
	"annotation_set_id" int NOT NULL DEFAULT next value for "sys"."seq_annotation_set_id",
	"model_id" int NOT NULL,
	"annotation_id" int NOT NULL,
	"annotation_sets_id" int NOT NULL,
	CONSTRAINT "annotation_set_annotation_set_id_pkey" PRIMARY KEY ("annotation_set_id"),
	CONSTRAINT "unq_model_annotation_sets" UNIQUE ("annotation_sets_id", "model_id", "annotation_id")
);
CREATE TABLE "sys"."production" (
	"production_id" int NOT NULL DEFAULT next value for "sys"."seq_production_id",
	"file_id" int NOT NULL,
	"model_sets_name_id" int NOT NULL,
	"production_type_id" int NOT NULL,
	"added" timestamp(7) NOT NULL,
	"production_start" timestamp(7),
	"impala_version" varchar(128),
	"impala_ready" timestamp(7),
	"sql_ready" timestamp(7),
	"sql_schema_version" varchar(16),
	"database_ready" timestamp(7),
	"production_ready" timestamp(7),
	"available" boolean NOT NULL DEFAULT false,
	"preferred" boolean NOT NULL DEFAULT false,
	CONSTRAINT "production_production_id_pkey" PRIMARY KEY ("production_id"),
	CONSTRAINT "unq_production_file_id" UNIQUE ("file_id", "model_sets_name_id")
);
CREATE TABLE "sys"."score" (
	"score_id" bigint NOT NULL DEFAULT next value for "sys"."seq_score_id",
	"fragment_id" bigint NOT NULL,
	"model_sets_id" int NOT NULL,
	"file_id" int NOT NULL,
	"confidence" real NOT NULL,
	CONSTRAINT "score_score_id_pkey" PRIMARY KEY ("score_id"),
	CONSTRAINT "unq_score_fragment" UNIQUE ("fragment_id", "model_sets_id", "file_id")
);
CREATE TABLE "sys"."video_set" (
	"video_set_id" int NOT NULL DEFAULT next value for "sys"."seq_video_set_id",
	"video_sets_id" int NOT NULL,
	"file_id" int NOT NULL,
	CONSTRAINT "video_set_video_set_id_pkey" PRIMARY KEY ("video_set_id"),
	CONSTRAINT "unq_video_set_video_sets" UNIQUE ("video_sets_id", "file_id")
);
create function get_video_sets_id(setname varchar(128))
returns integer
begin
  return
    select video_sets_id
    from video_sets
    where set_name = setname;
end;
create function get_next_file_quid(video_sets_name varchar(128))
returns bigint
begin
  declare next_file_quid bigint;
--  set next_file_quid = null;
  set next_file_quid = -1;

  declare video_sets_identifier integer;

  set video_sets_identifier = (select identifier
                               from   video_sets
                               where  set_name = video_sets_name);

  if video_sets_identifier is not null then
    declare next_file_number integer;

    -- the next id to be inserted is equal to the current number 
    -- of files in the set. 
    set next_file_number = (select count(v1.video_set_id)
                            from   video_set as v1,
                                   video_sets as v2
                            where  v1.video_sets_id = v2.video_sets_id
                            and    v2.identifier = video_sets_identifier);
 
    declare quid_class_video integer;
    set quid_class_video = 6;
/*
    set next_file_quid = (quid_class_video ^ 7) + 
                         (video_sets_identifier ^ 6) + 
                         next_file_number;
*/
    set next_file_quid = 86046057 + next_file_number;
  end if;

  return next_file_quid;
end;
create function add_file (id_media integer,
                          setname varchar(128),
                          namefile varchar(256),
                          file_codec varchar(64),
                          file_bitrate varchar(64),
                          file_identifier varchar(64),
                          url_download varchar(256),
                          url_account varchar(128),
                          file_width integer,
                          file_height integer) 
returns integer
begin
  declare next_quid bigint;
  set next_quid = get_next_file_quid(setname);
 
  insert into file (
      media_id,
      filename,
      codec,
      bitrate,
      identifier,
      quid,
      download_url,
      account_name,
      width,
      height )
  values (
      id_media,
      namefile,
      file_codec,
      file_bitrate,
      file_identifier,
      next_quid,
      url_download,
      url_account,
      file_width,
      file_height );

  declare id_file integer;
  set id_file = (select max(file_id)
                 from file);

  declare id_video_sets integer;
  set id_video_sets = get_video_sets_id(setname);

  insert into video_set (
      video_sets_id,
      file_id )
  values (
      id_video_sets,
      id_file );

  return id_file;
end;
create function get_next_media_quid()
returns integer
begin
  return 
    select max(quid) + 1
    from media;
end;
create function add_media (id_event integer,
                           id_media_description integer,
                           media_identifier varchar(128),
                           quid bigint,
                           rate_frame integer,
                           count_frame integer) 
returns integer
begin
  declare next_quid bigint;
-- This one has a bootstrap problem
--  set next_quid = get_next_media_quid();
  set next_quid = quid;
 
  insert into media (
      event_id,
      media_description_id,
      identifier,
      quid,
      frame_rate,
      frame_count )
  values (
      id_event,
      id_media_description,
      media_identifier,
      next_quid,
      rate_frame,
      count_frame );

  declare id_media integer;
  set id_media = (select max(media_id)
                  from media);

  return id_media;
end;
create function get_videodata_id (id_production integer) 
returns bigint
begin
  return
    select count(video_set_id) - 1
    from   video_set
    where  video_sets_id = get_video_sets_id('fabchannel2007devel');
end;
create function
i_add_model_sets(videosetname varchar(128), conceptsetname varchar(128),
                 keyword varchar(128), modelname varchar(256),
                 setname varchar(128))
returns integer
begin
    declare vsetsid integer;
    set vsetsid = (select video_sets_id from video_sets where set_name = videosetname);

    declare keysetsid integer;
    set keysetsid = (select keyword_sets_id from keyword_sets where set_name = conceptsetname and video_sets_id = vsetsid);

    declare keyid integer;
    set keyid = (select keyword_id from keyword where keyword_name = keyword);

    declare modelrefid integer;

    set modelrefid = (select m.model_ref_id 
                      from   model_ref as m,
                             keyword_set as k
                      where  m.model_name = modelname 
                      and    m.keyword_set_id = k.keyword_set_id
                      and    k.keyword_sets_id = keysetsid 
                      and    k.keyword_id = keyid);

    if modelrefid is null then
        declare keywordsetid int;
        set keywordsetid = (select keyword_set_id
                            from   keyword_set
                            where  keyword_sets_id = keysetsid
                            and    keyword_id = keyid);
 
        set modelrefid = (select max(model_ref_id) + 1 from model_ref);
        if modelrefid is null then
            set modelrefid = 1;
        end if;
        insert into model_ref values (modelrefid, modelname, keywordsetid);
    end if;

    declare modelsetsnameid int;
    set modelsetsnameid = (select model_sets_name_id
                           from   model_sets_name
                           where  set_name = setname);
    if modelsetsnameid is null then
        set modelsetsnameid = (select max(model_sets_name_id) + 1 from model_sets_name);
        if modelsetsnameid is null then
            set modelsetsnameid = 1;
        end if;
        insert into model_sets_name values (modelsetsnameid, setname);
    end if;

    insert into model_sets (model_ref_id, model_sets_name_id) 
    values (modelrefid, modelsetsnameid);

    return 0;
end;
create function
i_add_model_to_set(videosetname varchar(128), conceptsetname varchar(128),
                   keyword varchar(128), modelname varchar(256),
                   setname varchar(128), featurename varchar(128))
returns integer
begin
    declare vsetsid integer;
    set vsetsid = (select video_sets_id from video_sets where set_name = videosetname);

    declare keysetsid integer;
    set keysetsid = (select keyword_sets_id from keyword_sets where set_name = conceptsetname and video_sets_id = vsetsid);

    declare keyid integer;
    set keyid = (select keyword_id from keyword where keyword_name = keyword);

    declare modelrefid integer;
    set modelrefid = (select m.model_ref_id 
                      from   model_ref as m,
                             keyword_set as k
                      where  m.model_name = modelname 
                      and    m.keyword_set_id = k.keyword_set_id
                      and    k.keyword_sets_id = keysetsid 
                      and    k.keyword_id = keyid);

    declare modelsetsnameid int;
    set modelsetsnameid = (select model_sets_name_id
                           from   model_sets_name
                           where  set_name = setname);

    declare modelsetsid integer;
    set modelsetsid = (select model_sets_id 
                       from model_sets 
                       where model_sets_name_id = modelsetsnameid
                       and model_ref_id = modelrefid); 

    declare featureid integer;
    set featureid = (select feature_id from feature where feature_name = featurename);

    declare modelid integer;
    set modelid = (select model_id from model where model_ref_id = modelrefid and feature_id = featureid);

    insert into model_set (model_sets_id, model_id) values (modelsetsid, modelid);

    return 0;
end;
create function
i_add_model(videosetname varchar(128), conceptsetname varchar(128),
            keyword varchar(128), modelname varchar(256),
            featurename varchar(128))
returns integer
begin
    declare vsetsid integer;
    set vsetsid = (select video_sets_id from video_sets where set_name = videosetname);

    declare keysetsid integer;
    set keysetsid = (select keyword_sets_id from keyword_sets where set_name = conceptsetname and video_sets_id = vsetsid);

    declare keyid integer;
    set keyid = (select keyword_id from keyword where keyword_name = keyword);

    declare featureid integer;
    set featureid = (select feature_id from feature where feature_name = featurename);

    declare modelrefid integer;
    set modelrefid = (select m.model_ref_id 
                      from   model_ref as m,
                             keyword_set as k
                      where  m.model_name = modelname 
                      and    m.keyword_set_id = k.keyword_set_id
                      and    k.keyword_sets_id = keysetsid 
                      and    k.keyword_id = keyid);

    if modelrefid is null then
        declare keywordsetid int;
        set keywordsetid = (select keyword_set_id
                            from   keyword_set
                            where  keyword_sets_id = keysetsid
                            and    keyword_id = keyid);
 
        set modelrefid = (select max(model_ref_id) + 1 from model_ref);
        if modelrefid is null then
            set modelrefid = 1;
        end if;

        insert into model_ref values (modelrefid, modelname, keywordsetid);
    end if;

    insert into model (model_ref_id, feature_id) values (modelrefid, featureid);

    return 0;
end;
create function
i_add_annotator(annotatorname varchar(128), annotatortype varchar(64), appr boolean)
returns integer
begin
    declare annotatorid integer;
    set annotatorid = (select annotator_id from annotator where annotator_name = annotatorname);
    if annotatorid is null then
        insert into annotator(annotator_name, annotator_type, approved) values (annotatorname, annotatortype, appr);
    end if;

    return 0;
end;
create function
i_add_feature(featurename varchar(128))
returns integer
begin
    declare featid integer;
    set featid = (select feature_id from feature where feature_name = featurename);
    if featid is null then
        insert into feature(feature_name) values (featurename);
    end if;

    return 0;
end;
create function
i_add_keyword(videosetname varchar(128), conceptsetname varchar(128),
              keyword varchar(128))
returns integer
begin
    declare vsetsid integer;
    set vsetsid = (select video_sets_id from video_sets where set_name = videosetname);

    declare keysetsid integer;
    set keysetsid = (select keyword_sets_id from keyword_sets where set_name = conceptsetname and video_sets_id = vsetsid);
    if keysetsid is null then
        set keysetsid = (select max(keyword_sets_id) + 1 from keyword_sets);
        if keysetsid is null then
            set keysetsid = 1;
        end if;
        insert into keyword_sets values (keysetsid, conceptsetname, vsetsid);
    end if;

    declare keyid integer;
    set keyid = (select keyword_id from keyword where keyword_name = keyword);
    if keyid is null then
        set keyid = (select max(keyword_id) + 1 from keyword);
        if keyid is null then
            set keyid = 1;
        end if;
        insert into keyword values (keyid, keyword);
    end if;

    declare keysetid integer;
    set keysetid = (select keyword_set_id from keyword_set where keyword_sets_id = keysetsid and keyword_id = keyid);
    if  keysetid is null then
        insert into keyword_set (keyword_sets_id, keyword_id)
               values (keysetsid, keyid);
    end if;

    return 0;
end;
create function add_media_description (description_media varchar(64)) 
returns integer
begin
  insert into media_description (
      description )
  values (
      description_media );

  declare id_media_description integer;
  set id_media_description = (select max(media_description_id)
                              from media_description);

  return id_media_description;
end;
create function add_event (name_event varchar(256),
                           date_event date,
                           event_artist varchar(256),
                           event_location varchar(256),
                           event_description varchar(256)) 
returns integer
begin
  insert into event (
      event_name,
      event_date,
      description )
  values (
      name_event,
      date_event,
      event_description );

  declare id_event integer;
  set id_event = (select max(event_id)
                  from   event);

  if event_artist is not null 
    then
      insert into event_metadata (
        event_id,
        metadata_name,
        metadata_value )
      values (
        id_event,
        'artist',
        event_artist );
    end if;

  if event_location is not null
    then
      insert into event_metadata (
        event_id,
        metadata_name,
        metadata_value )
      values (
        id_event,
        'location',
        event_location );
    end if;
      
  return id_event;
end;
create function
i_add_video_file(mediadescription varchar(64), setname varchar(128), 
                 quid bigint, filename varchar(256),
                 width integer, height integer, framerate real,
                 framecount integer, codec varchar(64), bitrate varchar(64))
returns integer
begin
    declare mediadescriptionid integer;
    set mediadescriptionid = (select media_description_id from media_description where description = mediadescription);
    if mediadescriptionid is null then
      set mediadescriptionid = add_media_description('dummy description');
    end if;

    declare eventid integer;
    declare eventname varchar(256);
    set eventname = concat(concat(setname, '_'), quid);

    set eventid = (select event_id from event where event_name = eventname);
    if eventid is null then
        set eventid = add_event(eventname, '2000-01-01', 'no artist', 'no location', 
                                'no description');
    end if;

    declare mediaid integer;
    set mediaid = add_media(eventid, 
                            mediadescriptionid, 
                            quid,
                            quid,
                            framerate, 
                            framecount);

    declare fileid integer;
    set fileid = add_file(mediaid, 
                          setname,
                          filename, 
                          codec, 
                          bitrate,
                          quid, 
                          'url', 
                          'empty', 
                          width, 
                          height);

    return 0;
end;
create function
i_add_video_file_event(setname varchar(128), eventname varchar(256),
                       mediadescription varchar(64), quid bigint, filename varchar(256),
                       width integer, height integer, framerate real,
                       framecount integer, codec varchar(64), bitrate varchar(64))
returns integer
begin
    declare eventid integer;
    set eventid = (select event_id from event where event_name = eventname);
    if eventid is null then
        set eventid = add_event(eventname, '2000-01-01', 'no artist', 'no location', 
                                'no description');
    end if;

    declare mediadescriptionid integer;
    set mediadescriptionid = (select media_description_id from media_description
                              where description = mediadescription);
    if mediadescriptionid is null then
      set mediadescriptionid = add_media_description(mediadescription);
    end if;

    declare mediaid integer;
    set mediaid = (select media_id from media
                   where event_id = eventid and
                         media_description_id = mediadescriptionid);
    if mediaid is null then
        set mediaid = add_media(eventid, 
                                mediadescriptionid, 
                                quid,
                                quid,
                                framerate, 
                                framecount);
    end if;

    declare fileid integer;
    set fileid = add_file(mediaid, 
                          setname,
                          filename, 
                          codec, 
                          bitrate,
                          quid, 
                          'url', 
                          'empty', 
                          width, 
                          height);

    return 0;
end;
create function
i_add_video_set(ident integer, setname varchar(128))
returns integer
begin
    insert into video_sets (identifier, set_name) values (ident, setname);
    return 0;
end;
create function add_production (id_file integer,
                                id_model_sets_name integer,
                                id_production_type integer) 
returns integer
begin
  insert into production (
      file_id,
      model_sets_name_id,
      production_type_id,
      added)
  values (
      id_file,
      id_model_sets_name,
      id_production_type,
      current_timestamp()
  );

  return 0;
end;
create function check_available(namefile varchar(256))
returns boolean
begin
  return
    select p.available
    from   production as p,
           file as f
    where  p.file_id = f.file_id
    and    f.filename = namefile;
end;
create function check_mpeg7()
returns integer
begin
  return
    select production_id
    from   production
    where  impala_ready is not null
    and    sql_ready is null
    limit 1;  
end;
create function check_mpeg7_sql()
returns integer
begin
  return
    select production_id
    from   production
    where  impala_ready is not null
    and    sql_ready is not null
    and    database_ready is null
    limit 1;
end;
create function check_sql_ready()
returns integer
begin
  return  
    select production_id
    from   production
    where  impala_ready is not null
    and    sql_ready is not null
    and    database_ready is not null
    and    production_ready is null
    limit 1;
end;
create function get_account_name(id_production integer) 
returns varchar(128)
begin
  return
    select f.account_name
    from   production as p,
           file as f
    where  f.file_id = p.file_id
    and    production_id = id_production;
end;
create function get_file_url(id_production integer)
returns varchar(256)
begin
  return
    select f.download_url
    from   file as f,
           production as p
    where  f.file_id = p.file_id
    and    p.production_id = id_production;
end;
create function get_model_sets_name (id_production integer)
returns varchar(32)
  return
    select m.set_name
    from   production as p,
           model_sets_name as m
    where  m.model_sets_name_id = p.model_sets_name_id
    and    p.production_id = id_production;
create function get_next_production (
) returns integer
begin
  return
    select production_id
    from   production
    where  impala_ready is null
    limit 1;
end;
create function get_production_filename (id_production integer) 
returns varchar(256)
begin
  return
    select f.filename
    from   file as f,
           production as p
    where  f.file_id = p.file_id
    and    p.production_id = id_production;    
end;
create function get_production_quid (id_production integer) 
returns bigint
begin
  return
    select f.quid
    from   file as f,
           production as p
    where  f.file_id = p.file_id
    and    p.production_id = id_production;    
end;
create function get_production_type (id_production integer)
returns varchar(32)
  return
    select t.production_steps
    from   production as p,
           production_type as t
    where  t.production_type_id = p.production_type_id
    and    p.production_id = id_production;
create function list_available()
returns table(filename varchar(256))
begin
  return table (
    select f.filename
    from   file as f,
           production as p
    where  f.file_id = p.file_id
    and    p.available = true );
end;
create function set_available(id_production integer)
returns integer
begin
  update production
    set production_ready = current_timestamp(),
        available = true
  where production_id = id_production;

  return 0;
end;
create function set_impala_ready (id_production integer,
                                  version_impala varchar(128))
returns integer
begin
  update production
    set impala_ready = current_timestamp(),
        impala_version = version_impala
  where production_id = id_production;

  return 0;
end;
create function set_mpeg7_ready(id_production integer,
                                version_sql_schema varchar(16))
returns integer
begin
  update production
    set sql_ready = current_timestamp(),
        sql_schema_version = version_sql_schema
  where production_id = id_production;

  return 0;
end;
create function set_sql_ready(id_production integer)
returns integer
begin
  update production
    set database_ready = current_timestamp()
  where production_id = id_production;

  return 0;
end;
create function start_production(id_production integer)
returns integer
begin
  update production
    set  production_start = current_timestamp()
  where production_id = id_production;

  return 0;
end;
SET SCHEMA "sys";
ALTER TABLE "sys"."annotation" ADD CONSTRAINT "fk_annotation_annotator_id" FOREIGN KEY ("annotator_id") REFERENCES "sys"."annotator" ("annotator_id");
ALTER TABLE "sys"."annotation" ADD CONSTRAINT "fk_annotation_fragment_id" FOREIGN KEY ("fragment_id") REFERENCES "sys"."fragment" ("fragment_id");
ALTER TABLE "sys"."annotation" ADD CONSTRAINT "fk_annotation_keyword_id" FOREIGN KEY ("keyword_id") REFERENCES "sys"."keyword" ("keyword_id");
ALTER TABLE "sys"."annotation_set" ADD CONSTRAINT "fk_annotation_set_annotation_id" FOREIGN KEY ("annotation_id") REFERENCES "sys"."annotation" ("annotation_id");
ALTER TABLE "sys"."annotation_set" ADD CONSTRAINT "fk_annotation_set_annotation_sets_id" FOREIGN KEY ("annotation_sets_id") REFERENCES "sys"."annotation_sets" ("annotation_sets_id");
ALTER TABLE "sys"."annotation_set" ADD CONSTRAINT "fk_annotation_set_model_id" FOREIGN KEY ("model_id") REFERENCES "sys"."model" ("model_id");
ALTER TABLE "sys"."event_metadata" ADD CONSTRAINT "fk_event_metadata_event_id" FOREIGN KEY ("event_id") REFERENCES "sys"."event" ("event_id");
ALTER TABLE "sys"."feature_vector" ADD CONSTRAINT "fk_feature_vector_feature_id" FOREIGN KEY ("feature_id") REFERENCES "sys"."feature" ("feature_id");
ALTER TABLE "sys"."feature_vector" ADD CONSTRAINT "fk_feature_vector_file_id" FOREIGN KEY ("file_id") REFERENCES "sys"."file" ("file_id");
ALTER TABLE "sys"."feature_vector" ADD CONSTRAINT "fk_feature_vector_fragment_id" FOREIGN KEY ("fragment_id") REFERENCES "sys"."fragment" ("fragment_id");
ALTER TABLE "sys"."file" ADD CONSTRAINT "fk_file_media_id" FOREIGN KEY ("media_id") REFERENCES "sys"."media" ("media_id");
ALTER TABLE "sys"."fragment" ADD CONSTRAINT "fk_fragment_media_id" FOREIGN KEY ("media_id") REFERENCES "sys"."media" ("media_id");
ALTER TABLE "sys"."frame_image" ADD CONSTRAINT "fk_frame_image_fragment_id" FOREIGN KEY ("fragment_id") REFERENCES "sys"."fragment" ("fragment_id");
ALTER TABLE "sys"."keyword_set" ADD CONSTRAINT "fk_keyword_set_keyword_id" FOREIGN KEY ("keyword_id") REFERENCES "sys"."keyword" ("keyword_id");
ALTER TABLE "sys"."keyword_set" ADD CONSTRAINT "fk_keyword_set_keyword_sets_id" FOREIGN KEY ("keyword_sets_id") REFERENCES "sys"."keyword_sets" ("keyword_sets_id");
ALTER TABLE "sys"."keyword_sets" ADD CONSTRAINT "fk_keyword_sets_video_sets_id" FOREIGN KEY ("video_sets_id") REFERENCES "sys"."video_sets" ("video_sets_id");
ALTER TABLE "sys"."media" ADD CONSTRAINT "fk_media_description_id" FOREIGN KEY ("media_description_id") REFERENCES "sys"."media_description" ("media_description_id");
ALTER TABLE "sys"."media" ADD CONSTRAINT "fk_media_event_id" FOREIGN KEY ("event_id") REFERENCES "sys"."event" ("event_id");
ALTER TABLE "sys"."model" ADD CONSTRAINT "fk_model_feature_id" FOREIGN KEY ("feature_id") REFERENCES "sys"."feature" ("feature_id");
ALTER TABLE "sys"."model" ADD CONSTRAINT "fk_model_model_ref_id" FOREIGN KEY ("model_ref_id") REFERENCES "sys"."model_ref" ("model_ref_id");
ALTER TABLE "sys"."model_ref" ADD CONSTRAINT "fk_model_ref_keyword_set_id" FOREIGN KEY ("keyword_set_id") REFERENCES "sys"."keyword_set" ("keyword_set_id");
ALTER TABLE "sys"."model_set" ADD CONSTRAINT "fk_model_set_model_id" FOREIGN KEY ("model_id") REFERENCES "sys"."model" ("model_id");
ALTER TABLE "sys"."model_set" ADD CONSTRAINT "fk_model_set_model_sets_id" FOREIGN KEY ("model_sets_id") REFERENCES "sys"."model_sets" ("model_sets_id");
ALTER TABLE "sys"."model_sets" ADD CONSTRAINT "fk_model_sets_model_ref_id" FOREIGN KEY ("model_ref_id") REFERENCES "sys"."model_ref" ("model_ref_id");
ALTER TABLE "sys"."model_sets" ADD CONSTRAINT "fk_model_sets_name_id" FOREIGN KEY ("model_sets_name_id") REFERENCES "sys"."model_sets_name" ("model_sets_name_id");
ALTER TABLE "sys"."production" ADD CONSTRAINT "fk_production_file_id" FOREIGN KEY ("file_id") REFERENCES "sys"."file" ("file_id");
ALTER TABLE "sys"."production" ADD CONSTRAINT "fk_production_model_sets_name_id" FOREIGN KEY ("model_sets_name_id") REFERENCES "sys"."model_sets_name" ("model_sets_name_id");
ALTER TABLE "sys"."production" ADD CONSTRAINT "fk_production_production_type_id" FOREIGN KEY ("production_type_id") REFERENCES "sys"."production_type" ("production_type_id");
ALTER TABLE "sys"."score" ADD CONSTRAINT "fk_score_file_id" FOREIGN KEY ("file_id") REFERENCES "sys"."file" ("file_id");
ALTER TABLE "sys"."score" ADD CONSTRAINT "fk_score_fragment_id" FOREIGN KEY ("fragment_id") REFERENCES "sys"."fragment" ("fragment_id");
ALTER TABLE "sys"."score" ADD CONSTRAINT "fk_score_model_sets_id" FOREIGN KEY ("model_sets_id") REFERENCES "sys"."model_sets" ("model_sets_id");
ALTER TABLE "sys"."video_set" ADD CONSTRAINT "fk_video_set_file_id" FOREIGN KEY ("file_id") REFERENCES "sys"."file" ("file_id");
ALTER TABLE "sys"."video_set" ADD CONSTRAINT "fk_video_set_video_sets_id" FOREIGN KEY ("video_sets_id") REFERENCES "sys"."video_sets" ("video_sets_id");
ALTER SEQUENCE "sys"."seq_annotator_id" RESTART WITH 1 MINVALUE 1 NO CYCLE;
ALTER SEQUENCE "sys"."seq_event_id" RESTART WITH 1 MINVALUE 1 NO CYCLE;
ALTER SEQUENCE "sys"."seq_event_metadata_id" RESTART WITH 1 MINVALUE 1 NO CYCLE;
ALTER SEQUENCE "sys"."seq_feature_id" RESTART WITH 1 MINVALUE 1 NO CYCLE;
ALTER SEQUENCE "sys"."seq_keyword_id" RESTART WITH 1 MINVALUE 1 NO CYCLE;
ALTER SEQUENCE "sys"."seq_media_description_id" RESTART WITH 2 MINVALUE 1 NO CYCLE;
ALTER SEQUENCE "sys"."seq_model_sets_name_id" RESTART WITH 1 MINVALUE 1 NO CYCLE;
ALTER SEQUENCE "sys"."seq_video_sets_id" RESTART WITH 1 MINVALUE 1 NO CYCLE;
ALTER SEQUENCE "sys"."seq_annotation_sets_id" RESTART WITH 1 MINVALUE 1 NO CYCLE;
ALTER SEQUENCE "sys"."seq_production_type_id" RESTART WITH 1 MINVALUE 1 NO CYCLE;
ALTER SEQUENCE "sys"."seq_media_id" RESTART WITH 1 MINVALUE 1 NO CYCLE;
ALTER SEQUENCE "sys"."seq_file_id" RESTART WITH 1 MINVALUE 1 NO CYCLE;
ALTER SEQUENCE "sys"."seq_fragment_id" RESTART WITH 1 MINVALUE 1 NO CYCLE;
ALTER SEQUENCE "sys"."seq_feature_vector_id" RESTART WITH 1 MINVALUE 1 NO CYCLE;
ALTER SEQUENCE "sys"."seq_annotation_id" RESTART WITH 1 MINVALUE 1 NO CYCLE;
ALTER SEQUENCE "sys"."seq_frame_image_id" RESTART WITH 1 MINVALUE 1 NO CYCLE;
ALTER SEQUENCE "sys"."seq_keyword_sets_id" RESTART WITH 1 MINVALUE 1 NO CYCLE;
ALTER SEQUENCE "sys"."seq_keyword_set_id" RESTART WITH 1 MINVALUE 1 NO CYCLE;
ALTER SEQUENCE "sys"."seq_model_ref_id" RESTART WITH 1 MINVALUE 1 NO CYCLE;
ALTER SEQUENCE "sys"."seq_model_id" RESTART WITH 1 MINVALUE 1 NO CYCLE;
ALTER SEQUENCE "sys"."seq_model_sets_id" RESTART WITH 1 MINVALUE 1 NO CYCLE;
ALTER SEQUENCE "sys"."seq_model_set_id" RESTART WITH 1 MINVALUE 1 NO CYCLE;
ALTER SEQUENCE "sys"."seq_annotation_set_id" RESTART WITH 1 MINVALUE 1 NO CYCLE;
ALTER SEQUENCE "sys"."seq_production_id" RESTART WITH 1 MINVALUE 1 NO CYCLE;
ALTER SEQUENCE "sys"."seq_score_id" RESTART WITH 1 MINVALUE 1 NO CYCLE;
ALTER SEQUENCE "sys"."seq_video_set_id" RESTART WITH 1 MINVALUE 1 NO CYCLE;
COMMIT;
