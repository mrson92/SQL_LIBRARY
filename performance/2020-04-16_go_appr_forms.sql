2020-04-16 20:39:35 KST LOG:  duration: 233.747 ms  execute <unnamed>: select form0_.id as id1_124_, form0_.created_at as created_2_124_, form0_.updated_at as updated_3_124_, form0_.act_copy_alterable as act_copy4_124_, form0_.activity_editable as activity5_124_, form0_.admin_id as admin_i37_124_, form0_.alias as alias6_124_, form0_.allow_mobile_approval as allow_mo7_124_, form0_.appr_line_rule_id as appr_li38_124_, form0_.arbt_decision_active as arbt_dec8_124_, form0_.assigned_activity_deletable as assigned9_124_, form0_.code as code10_124_, form0_.company_id as company39_124_, form0_.company_doc_folder_id as company40_124_, form0_.creator_id as creator41_124_, form0_.document_editable as documen11_124_, form0_.document_open_editable as documen12_124_, form0_.document_openable as documen13_124_, form0_.external_script as externa14_124_, form0_.folder_id as folder_42_124_, form0_.folder_changeable as folder_15_124_, form0_.form_help_id as form_he43_124_, form0_.form_user_id as form_us44_124_, form0_.form_user_scope as form_us16_124_, form0_.integration_bean_name as integra17_124_, form0_.integration_name as integra18_124_, form0_.is_integration_active as is_inte19_124_, form0_.latest_version as latest_20_124_, form0_.name as name21_124_, form0_.official_document_sendable as officia22_124_, form0_.official_form_id as officia45_124_, form0_.official_sender_id as officia46_124_, form0_.official_sign_id as officia47_124_, form0_.origin_id as origin_48_124_, form0_.preserve_duration_editable as preserv23_124_, form0_.preserve_duration_in_year as preserv24_124_, form0_.reader_id as reader_49_124_, form0_.reader_active as reader_25_124_, form0_.receiver_id as receive50_124_, form0_.receiver_editable as receive26_124_, form0_.reception_active as recepti27_124_, form0_.reference_active as referen28_124_, form0_.referrer_id as referre51_124_, form0_.referrer_editable as referre29_124_, form0_.script_body_id as script_52_124_, form0_.security_level_id as securit53_124_, form0_.security_level_active as securit30_124_, form0_.security_level_editable as securit31_124_, form0_.seq as seq32_124_, form0_.state as state33_124_, form0_.template_id as templat54_124_, form0_.type as type34_124_, form0_.use_help as use_hel35_124_, form0_.version as version36_124_ from go_appr_forms form0_ left outer join go_appr_form_folders formfolder1_ on form0_.folder_id=formfolder1_.id where formfolder1_.id=$1 and form0_.state<>$2 and form0_.latest_version=true
2020-04-16 20:39:35 KST DETAIL:  parameters: $1 = '11', $2 = 'DELETED'