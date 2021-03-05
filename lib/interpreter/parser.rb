require "parslet"

module ChatoMud
  module Grammar
    class Parser < Parslet::Parser
      # Alphanumerical & Spaces
      rule(:spaces)  { match('\s').repeat(1) }
      rule(:spaces?) { spaces.maybe }

      rule(:letter) { match("[a-zA-z]") }
      rule(:word)   { letter.repeat(1) }

      rule(:digit)  { match("[0-9]") }
      rule(:digit_non_zero) { match("[1-9]") }
      rule(:number) { digit_non_zero >> digit.repeat }

      rule(:code) { letter >> (letter | str("_") | digit).repeat(1) }

      # command
      #######################################################
      root(:command)

      rule(:command) do
        direction |
        group | follow_self | follow |
        exits |
        scan | directed_scan |
        look_at | look_at_on_another | look_in | look_around |
        get_ground | get_container | drop | drop_all | put | give |
        empty_on_ground | empty_into_another |
        fill | pour | pour_into | fuel |
        emoted_say | simple_say |
        emoted_tell | simple_tell |
        emoted_shout | simple_shout |
        echo | necho | pecho |
        as |
        kill | kill_incomplete |
        hit | hitonce |
        flee | simple_flee | retreat_incomplete | retreat |
        inventory |
        simple_emote |
        crafts |
        eat | drink |
        open_door | close_door |
        lock_door | unlock_door |
        open_item | close_item |
        lock_item | unlock_item |
        junk |
        simple_wear | directed_wear | remove |
        simplest_sheathe | simple_sheathe | directed_sheathe |
        simple_draw | draw |
        simple_news | simple_news_page | news | news_page |
        simple_rnews | rnews |
        read |
        simple_flip | flip | turn |
        tear |
        dip_picking | dip_dipping |
        title |
        post | write | wipe |
        wield |
        load | unload |
        fire |
        aim | aim_simple |
        dislodge | dislodge_simple |
        possess | release |
        who | awho |
        snoop |
        go | goto | teleport |
        calmdown | calmdown_all | calmdown_incomplete |
        activate | activate_all | activate_incomplete |
        grip |
        switch |
        set | set_stance | set_editor_echoes | set_pace |
        sound |
        light |
        stand | simple_sit | sit | rest |
        tables |
        score | health | skills |
        combat | armor |
        time |
        stop |
        quit |
        mudstats |
        spawn_npc | simple_spawn_npc |
        spawn_item | simple_spawn_item |
        invisible | visible |
        die
      end

      # emotes
      #######################################################
      rule(:emote_with_speech) do
        (
          str("@") >> str("").as(:at) |
          quoted_speech |
          ref.as(:ref) |
          spaces.as(:spaces) |
          emote_text.as(:emote_text)
        ).repeat(1).as(:emote)
      end

      rule(:emote_no_speech) do
        (
          str("@") >> str("").as(:at) |
          ref.as(:ref) |
          spaces.as(:spaces) |
          emote_text.as(:emote_text)
        ).repeat(1).as(:emote)
      end

      rule(:bracketed_emote) do
        str("(") >> emote_no_speech >> str(")")
      end

      rule(:quoted_speech) do
        str('"') >> emote_text.as(:quoted_speech) >> str('"')
      end

      rule(:emote_text) do
        (
          (str("*") | str("~") | str("@") | str("(") | str(")") | str('"')).absent? >>
          any
        ).repeat(1)
      end

      # emotes: refs
      #######################################################
      rule(:ref) do
        ref_character | ref_item
      end

      rule(:ref_character) do
        str("~").as(:type) >> kword.as(:target)
      end

      rule(:ref_item) do
        str("*").as(:type) >> kword.as(:target)
      end

      # emotes: kword
      #######################################################
      rule(:kword) do
        (number.as(:index) >> str(".")).maybe >> word.as(:word)
      end

      # speech
      #######################################################
      rule(:speech) do
        any.repeat(1).as(:speech)
      end

      # say & simple_say
      #######################################################
      rule(:emoted_tell) do
        (spaces? >> tell_c >> spaces >> kword.as(:target) >> spaces? >> bracketed_emote >> spaces? >> speech).as(:emoted_tell)
      end

      rule(:simple_tell) do
        (spaces? >> tell_c >> spaces >> kword.as(:target) >> spaces >> speech).as(:simple_tell)
      end

      rule(:tell_c) do
        str("tell") | str("tel") | str("te") | str("t")
      end

      # say & simple_say
      #######################################################
      rule(:emoted_say) do
        (spaces? >> say_c >> spaces? >> bracketed_emote >> spaces? >> speech).as(:emoted_say)
      end

      rule(:simple_say) do
        (spaces? >> say_c >> spaces >> speech).as(:simple_say)
      end

      rule(:say_c) do
        str("say") | str("sa")
      end

      # shout & simple_shout
      #######################################################
      rule(:emoted_shout) do
        (spaces? >> shout_c >> spaces? >> bracketed_emote >> spaces? >> speech).as(:emoted_shout)
      end

      rule(:simple_shout) do
        (spaces? >> shout_c >> spaces >> speech).as(:simple_shout)
      end

      rule(:shout_c) do
        str("shout") | str("shou") | str("sho")
      end

      # echo
      #######################################################
      rule(:echo) do
        (spaces? >> echo_c >> spaces >> speech).as(:echo)
      end

      rule(:echo_c) do
        str("echo") | str("ech") | str("ec")
      end

      # as
      #######################################################
      rule(:as) do
        (spaces? >> as_c >> spaces >> kword.as(:target) >> spaces >> speech).as(:as)
      end

      rule(:as_c) do
        str("as")
      end

      # pecho
      #######################################################
      rule(:pecho) do
        (spaces? >> pecho_c >> spaces >> kword.as(:target) >> spaces >> speech).as(:pecho)
      end

      rule(:pecho_c) do
        str("pecho") | str("pech") | str("pec") | str("pe")
      end

      # necho
      #######################################################
      rule(:necho) do
        (spaces? >> necho_c >> spaces >> code.as(:name) >> spaces >> speech).as(:necho)
      end

      rule(:necho_c) do
        str("necho") | str("nech") | str("nec")
      end

      # mudstats
      #######################################################
      rule(:mudstats) do
        spaces? >> mudstats_c >> spaces? >> str("").as(:mudstats)
      end

      rule(:mudstats_c) do
        str("mudstats") | str("mudstat") | str("mudsta") | str("mudst") | str("muds") | str("mud")
      end

      # crafts
      #######################################################
      rule(:crafts) do
        (spaces? >> crafts_c >> spaces >> code.as(:category) >> spaces >> code.as(:name) >> spaces?).as(:crafts)
      end

      rule(:crafts_c) do
        str("crafts") | str("craft") | str("craf") | str("cra") | str("cr")
      end

      # eat
      #######################################################
      rule(:eat) do
        (spaces? >> eat_c >> spaces >> kword.as(:target) >> (spaces? >> str(".") >> str("").as(:ground)).maybe >> (spaces >> number.as(:amount)).maybe >> spaces?).as(:eat)
      end

      rule(:eat_c) do
        str("eat")
      end

      # drink
      #######################################################
      rule(:drink) do
        (spaces? >> drink_c >> spaces >> kword.as(:target) >> (spaces? >> str(".") >> str("").as(:ground)).maybe >> (spaces >> number.as(:amount)).maybe >> spaces?).as(:drink)
      end

      rule(:drink_c) do
        str("drink") | str("drin") | str("dri")
      end

      # junk
      #######################################################
      rule(:junk) do
        (spaces? >> junk_c >> spaces >> kword.as(:target) >> spaces?).as(:junk)
      end

      rule(:junk_c) do
        str("junk")
      end

      # simple_wear & directed_wear
      #######################################################
      rule(:simple_wear) do
        (spaces? >> wear_c >> spaces >> kword.as(:target) >> spaces?).as(:simple_wear)
      end

      rule(:directed_wear) do
        (spaces? >> wear_c >> spaces >> kword.as(:target) >> spaces >> word.as(:slot) >> spaces?).as(:directed_wear)
      end

      rule(:wear_c) do
        str("wear") | str("wea")
      end

      # simplest_sheathe & simple_sheathe & directed_sheathe
      #######################################################
      rule(:simplest_sheathe) do
        spaces? >> sheathe_c >> spaces? >> str("").as(:simplest_sheathe)
      end

      rule(:simple_sheathe) do
        (spaces? >> sheathe_c >> spaces >> kword.as(:target) >> spaces?).as(:simple_sheathe)
      end

      rule(:directed_sheathe) do
        (spaces? >> sheathe_c >> spaces >> kword.as(:target) >> spaces >> kword.as(:sheath) >> spaces?).as(:directed_sheathe)
      end

      rule(:sheathe_c) do
        str("sheathe") | str("sheath") | str("sheat") | str("shea") | str("she") | str("sh")
      end

      # simple_draw & draw
      #######################################################
      rule(:simple_draw) do
        spaces? >> draw_c >> spaces? >> str("").as(:simple_draw)
      end

      rule(:draw) do
        (spaces? >> draw_c >> spaces >> kword.as(:target) >> spaces?).as(:draw)
      end

      rule(:draw_c) do
        str("draw") | str("dra")
      end

      # wield
      #######################################################
      rule(:wield) do
        (spaces? >> wield_c >> spaces >> kword.as(:target) >> spaces?).as(:wield)
      end

      rule(:wield_c) do
        str("wield") | str("wiel") | str("wie") | str("wi")
      end

      # TODO: add directed_load i.e. the ability to choose the missile.
      # load
      #######################################################
      rule(:load) do
        spaces? >> load_c >> spaces? >> str("").as(:load)
      end

      rule(:load_c) do
        str("load") | str("loa")
      end

      # fire
      #######################################################
      rule(:fire) do
        spaces? >> fire_c >> spaces? >> str("").as(:fire)
      end

      rule(:fire_c) do
        str("fire") | str("ash") | str("fi")
      end

      # unload
      #######################################################
      rule(:unload) do
        spaces? >> unload_c >> spaces? >> str("").as(:unload)
      end

      rule(:unload_c) do
        str("unload") | str("unloa")
      end

      # aim & aim_simple
      #######################################################
      rule(:aim) do
        (spaces? >> aim_c >> spaces >> (north_c | east_c | south_c | west_c | up_c | down_c).as(:direction) >> spaces >> kword.as(:target) >> spaces?).as(:aim)
      end

      rule(:aim_simple) do
        (spaces? >> aim_c >> spaces >> kword.as(:target) >> spaces?).as(:aim_simple)
      end

      rule(:aim_c) do
        str("aim") | str("ai")
      end

      # dislodge & dislodge_simple
      #######################################################
      rule(:dislodge) do
        (spaces? >> dislodge_c >> spaces >> kword.as(:target) >> spaces >> code.as(:body_part) >> spaces?).as(:dislodge)
      end

      rule(:dislodge_simple) do
        (spaces? >> dislodge_c >> spaces >> code.as(:body_part) >> spaces?).as(:dislodge_simple)
      end

      rule(:dislodge_c) do
        str("dislodge") | str("dislodg") | str("dislod") | str("dislo") | str("disl")
      end

      # grip
      #######################################################
      rule(:grip) do
        spaces? >> grip_c >> spaces? >> str("").as(:grip)
      end

      rule(:grip_c) do
        str("grip") | str("gri") | str("gr")
      end

      # switch
      #######################################################
      rule(:switch) do
        spaces? >> switch_c >> spaces? >> str("").as(:switch)
      end

      rule(:switch_c) do
        str("switch") | str("switc") | str("swit") | str("swi")
      end

      # set & set_stance & set_editor_echoes
      #######################################################
      rule(:set) do
        spaces? >> set_c >> spaces? >> str("").as(:set)
      end

      rule(:set_stance) do
        (spaces? >> set_c >> spaces >> stance >> spaces >> word.as(:stance) >> spaces?).as(:set_stance)
      end

      rule(:set_editor_echoes) do
        (spaces? >> set_c >> spaces >> editor_echoes >> spaces >> word.as(:editor_echoes) >> spaces?).as(:set_editor_echoes)
      end

      rule(:set_pace) do
        (spaces? >> set_c >> spaces >> pace >> spaces >> word.as(:pace) >> spaces?).as(:set_pace)
      end

      rule(:set_c) do
        str("set") | str("se")
      end

      rule(:stance) do
        str("stance") | str("stanc") | str("stan") | str("sta") | str("st") | str("s")
      end

      rule(:editor_echoes) do
        str("editor_echoes") | str("editor_echoe") | str("editor_echo") | str("editor_ech") | str("editor_ec") | str("editor_e") | str("editor_") | str("editor") | str("edito") | str("edit") | str("edi") | str("ed") | str("e")
      end

      rule(:pace) do
        str("pace") | str("pac") | str("pa") | str("p")
      end

      # sound
      #######################################################
      rule(:sound) do
        (spaces? >> sound_c >> spaces >> kword.as(:target) >> spaces?).as(:sound)
      end

      rule(:sound_c) do
        str("sound") | str("soun")
      end

      # light
      #######################################################
      rule(:light) do
        (spaces? >> light_c >> spaces >> kword.as(:target) >> (spaces? >> str(".") >> str("").as(:ground)).maybe >> (spaces? >> off.as(:off)).maybe >> spaces?).as(:light)
      end

      rule(:off) do
        str("off") | str("of") | str("o")
      end

      rule(:light_c) do
        str("light") | str("ligh") | str("ligh") | str("lig") | str("li")
      end

      # sit
      #######################################################
      rule(:simple_sit) do
        spaces? >> sit_c >> spaces? >> str("").as(:simple_sit)
      end

      rule(:sit) do
        (spaces? >> sit_c >> spaces >> kword.as(:target) >> spaces?).as(:sit)
      end

      rule(:sit_c) do
        str("sit") | str("si")
      end

      # tables
      #######################################################
      rule(:tables) do
        spaces? >> tables_c >> spaces? >> str("").as(:tables)
      end

      rule(:tables_c) do
        str("tables") | str("table") | str("tabl") | str("tab") | str("ta") | str("t")
      end

      # stand
      #######################################################
      rule(:stand) do
        spaces? >> stand_c >> spaces? >> str("").as(:stand)
      end

      rule(:stand_c) do
        str("stand") | str("stan") | str("sta")
      end

      # rest
      #######################################################
      rule(:rest) do
        spaces? >> rest_c >> spaces? >> str("").as(:rest)
      end

      rule(:rest_c) do
        str("rest") | str("res")
      end

      # score
      #######################################################
      rule(:score) do
        spaces? >> score_c >> spaces? >> str("").as(:score)
      end

      rule(:score_c) do
        str("score") | str("scor") | str("sco") | str("sc")
      end

      # score
      #######################################################
      rule(:health) do
        spaces? >> health_c >> spaces? >> str("").as(:health)
      end

      rule(:health_c) do
        str("health") | str("healt") | str("heal") | str("hea") | str("he")
      end

      # skills
      #######################################################
      rule(:skills) do
        spaces? >> skills_c >> spaces? >> str("").as(:skills)
      end

      rule(:skills_c) do
        str("skills") | str("skill") | str("skil") | str("ski") | str("sk")
      end

      # combat
      #######################################################
      rule(:combat) do
        spaces? >> combat_c >> spaces? >> str("").as(:combat)
      end

      rule(:combat_c) do
        str("combat") | str("comba") | str("comb") | str("com") | str("co")
      end

      # armor
      #######################################################
      rule(:armor) do
        spaces? >> armor_c >> spaces? >> str("").as(:armor)
      end

      rule(:armor_c) do
        str("armor") | str("armo") | str("arm") | str("ar")
      end

      # time
      #######################################################
      rule(:time) do
        spaces? >> time_c >> spaces? >> str("").as(:time)
      end

      rule(:time_c) do
        str("time") | str("tim") | str("ti")
      end

      # quit
      #######################################################
      rule(:quit) do
        spaces? >> quit_c >> spaces? >> str("").as(:quit)
      end

      rule(:quit_c) do
        str("quit") | str("qui") | str("qu") | str("q")
      end

      # remove
      #######################################################
      rule(:remove) do
        (spaces? >> remove_c >> spaces >> kword.as(:target) >> spaces?).as(:remove)
      end

      rule(:remove_c) do
        str("remove") | str("remov") | str("remo") | str("rem") | str("re") | str("r")
      end

      # inventory
      #######################################################
      rule(:inventory) do
        spaces? >> inventory_c >> spaces? >> str("").as(:inventory)
      end

      rule(:inventory_c) do
        str("inventory") | str("inventor") | str("invento") | str("invent") | str("inven") | str("inve") | str("inv") | str("in") | str("i")
      end

      # spawn_npc & simple_spawn_npc
      #######################################################
      rule(:spawn_npc) do
        (spaces? >> spawn_npc_c >> spaces >> code.as(:npc_template_code) >> spaces >> code.as(:character_outfitter_code) >> spaces?).as(:spawn_npc)
      end

      rule(:simple_spawn_npc) do
        (spaces? >> spawn_npc_c >> spaces >> code.as(:npc_template_code) >> spaces?).as(:simple_spawn_npc)
      end

      rule(:spawn_npc_c) do
        str("spawn_npc") | str("spawn_np") | str("spawn_n")
      end

      # spawn_item & simple_spawn_item
      #######################################################
      rule(:spawn_item) do
        (spaces? >> spawn_item_c >> spaces >> code.as(:item_template_code) >> spaces >> code.as(:item_outfitter_code) >> spaces?).as(:spawn_item)
      end

      rule(:simple_spawn_item) do
        (spaces? >> spawn_item_c >> spaces >> code.as(:item_template_code) >> spaces?).as(:simple_spawn_item)
      end

      rule(:spawn_item_c) do
        str("spawn_item") | str("spawn_ite") | str("spawn_it") | str("spawn_i")
      end

      # visible
      #######################################################
      rule(:visible) do
        spaces? >> visible_c >> spaces? >> str("").as(:visible)
      end

      rule(:visible_c) do
        str("visible") | str("visibl") | str("visib") | str("visi") | str("vis")
      end

      # invisible
      #######################################################
      rule(:invisible) do
        spaces? >> invisible_c >> spaces? >> str("").as(:invisible)
      end

      rule(:invisible_c) do
        str("invisible") | str("invisibl") | str("invisib") | str("invisi") | str("invis") | str("invi")
      end

      # shutdown
      #######################################################
      rule(:shutdown) do
        spaces? >> shutdown_c >> spaces? >> str("").as(:shutdown)
      end

      rule(:shutdown_c) do
        str("shutdown")
      end

      # hit
      #######################################################
      rule(:hit) do
        (spaces? >> hit_c >> spaces >> kword.as(:target) >> spaces?).as(:hit)
      end

      rule(:hit_c) do
        str("hit") | str("hi") | str("h")
      end

      # flee & simple_flee
      #######################################################
      rule(:flee) do
        (spaces? >> flee_c >> spaces >> (north_c | east_c | south_c | west_c | up_c | down_c).as(:direction) >> spaces?).as(:flee)
      end

      rule(:simple_flee) do
        (spaces? >> flee_c >> spaces?).as(:simple_flee)
      end

      rule(:flee_c) do
        str("flee") | str("fle") | str("fl")
      end

      # retreat & retreat_incomplete
      #######################################################
      rule(:retreat) do
        (spaces? >> retreat_c >> spaces >> (north_c | east_c | south_c | west_c | up_c | down_c).as(:direction) >> spaces?).as(:retreat)
      end

      rule(:retreat_incomplete) do
        (spaces? >> retreat_c >> spaces?).as(:retreat_incomplete)
      end

      rule(:retreat_c) do
        str("retreat") | str("retrea") | str("retre") | str("retr")
      end

      # hitonce - DEBUG
      #######################################################
      rule(:hitonce) do
        (spaces? >> hitonce_c >> spaces >> kword.as(:target) >> spaces?).as(:hit_once)
      end

      rule(:hitonce_c) do
        str("hitonce") | str("hitonc") | str("hiton") | str("hito")
      end

      # stop
      #######################################################
      rule(:stop) do
        spaces? >> stop_c >> spaces? >> str("").as(:stop)
      end

      rule(:stop_c) do
        str("stop") | str("sto") | str("st")
      end

      # kill
      #######################################################
      rule(:kill) do
        (spaces? >> kill_c >> spaces >> kword.as(:target) >> spaces?).as(:kill)
      end

      rule(:kill_c) do
        str("kill")
      end

      # kill_incomplete
      #######################################################
      rule(:kill_incomplete) do
        (spaces? >> kill_incomplete_c >> spaces >> kword.as(:target) >> spaces?).as(:kill_incomplete)
      end

      rule(:kill_incomplete_c) do
        str("kil") | str("ki") | str("k")
      end

      # open door
      #######################################################
      rule(:open_door) do
        (spaces? >> open_c >> spaces >> (north_c | east_c | south_c | west_c | up_c | down_c).as(:direction) >> spaces?).as(:open_door)
      end

      rule(:open_c) do
        str("open") | str("ope") | str("op") | str("o")
      end

      # close door
      #######################################################
      rule(:close_door) do
        (spaces? >> close_c >> spaces >> (north_c | east_c | south_c | west_c | up_c | down_c).as(:direction) >> spaces?).as(:close_door)
      end

      rule(:close_c) do
        str("close") | str("clos") | str("clo") | str("cl")
      end

      # lock door
      #######################################################
      rule(:lock_door) do
        (spaces? >> lock_c >> spaces >> (north_c | east_c | south_c | west_c | up_c | down_c).as(:direction) >> spaces?).as(:lock_door)
      end

      rule(:lock_c) do
        str("lock") | str("loc")
      end

      # unlock door
      #######################################################
      rule(:unlock_door) do
        (spaces? >> unlock_c >> spaces >> (north_c | east_c | south_c | west_c | up_c | down_c).as(:direction) >> spaces?).as(:unlock_door)
      end

      rule(:unlock_c) do
        str("unlock") | str("unloc") | str("unlo") | str("unl")
      end

      # open item
      #######################################################
      rule(:open_item) do
        (spaces? >> open_c >> spaces >> kword.as(:target) >> (spaces? >> str(".") >> str("").as(:ground)).maybe >> spaces?).as(:open_item)
      end

      # close item
      #######################################################
      rule(:close_item) do
        (spaces? >> close_c >> spaces >> kword.as(:target) >> (spaces? >> str(".") >> str("").as(:ground)).maybe >> spaces?).as(:close_item)
      end

      # lock item
      #######################################################
      rule(:lock_item) do
        (spaces? >> lock_c >> spaces >> kword.as(:target) >> (spaces? >> str(".") >> str("").as(:ground)).maybe >> spaces?).as(:lock_item)
      end

      # unlock item
      #######################################################
      rule(:unlock_item) do
        (spaces? >> unlock_c >> spaces >> kword.as(:target) >> (spaces? >> str(".") >> str("").as(:ground)).maybe >> spaces?).as(:unlock_item)
      end

      # possess
      #######################################################
      rule(:possess) do
        (spaces? >> possess_c >> spaces >> kword.as(:target) >> spaces?).as(:possess)
      end

      rule(:possess_c) do
        str("possess") | str("posses") | str("posse") | str("poss")
      end

      # snoop
      #######################################################
      rule(:snoop) do
        (spaces? >> snoop_c >> spaces >> kword.as(:target) >> spaces?).as(:snoop)
      end

      rule(:snoop_c) do
        str("snoop") | str("snoo") | str("sno") | str("sn")
      end

      # who
      #######################################################
      rule(:who) do
        (spaces? >> who_c >> spaces?).as(:who)
      end

      rule(:who_c) do
        str("who") | str("wh")
      end

      # awho
      #######################################################
      rule(:awho) do
        (spaces? >> awho_c >> spaces?).as(:awho)
      end

      rule(:awho_c) do
        str("awho") | str("awh") | str("aw")
      end

      # go
      #######################################################
      rule(:go) do
        (spaces? >> go_c >> spaces >> number.as(:room_id) >> (spaces? >> str("!").as(:bang).maybe) >> str("").as(:is_room) >> spaces?).as(:go)
      end

      rule(:go_c) do
        str("go")
      end

      # goto
      #######################################################
      rule(:goto) do
        (spaces? >> goto_c >> spaces >> code.as(:name) >> (spaces? >> str("!").as(:bang).maybe) >> spaces?).as(:go)
      end

      rule(:goto_c) do
        str("goto") | str("got")
      end

      # teleport
      #######################################################
      rule(:teleport) do
        (spaces? >> teleport_c >> spaces >> kword.as(:target) >> spaces >> number.as(:room_id) >> (spaces? >> str("!").as(:bang).maybe) >> spaces?).as(:teleport)
      end

      rule(:teleport_c) do
        str("teleport") | str("telepor") | str("telepo") | str("telep") | str("tele")
      end

      # release
      #######################################################
      rule(:release) do
        spaces? >> release_c >> spaces? >> str("").as(:release)
      end

      rule(:release_c) do
        str("release") | str("releas") | str("relea") | str("rele") | str("rel")
      end

      # calmdown & calmdown_incomplete & calmdown_all
      #######################################################
      rule(:calmdown) do
        (spaces? >> calmdown_c >> spaces >> kword.as(:target) >> spaces?).as(:calmdown)
      end

      rule(:calmdown_incomplete) do
        (spaces? >> calmdown_c >> spaces?).as(:calmdown_incomplete)
      end

      rule(:calmdown_all) do
        (spaces? >> calmdown_c >> spaces >> str("*") >> spaces? >> str("")).as(:calmdown_all)
      end

      rule(:calmdown_c) do
        str("calmdown") | str("calmdow") | str("calmdo") | str("calmd") | str("calm") | str("cal") | str("ca")
      end

      # activate & activate_incomplete & activate_all
      #######################################################
      rule(:activate) do
        (spaces? >> activate_c >> spaces >> kword.as(:target) >> spaces?).as(:activate)
      end

      rule(:activate_incomplete) do
        (spaces? >> activate_c >> spaces?).as(:activate_incomplete)
      end

      rule(:activate_all) do
        (spaces? >> activate_c >> spaces >> str("*") >> spaces? >> str("")).as(:activate_all)
      end

      rule(:activate_c) do
        str("activate") | str("activat") | str("activa") | str("activ") | str("acti") | str("act") | str("ac")
      end

      # group
      #######################################################
      rule(:group_kick) do
        (spaces? >> group_c >> spaces?).as(:group)
      end

      rule(:group) do
        (spaces? >> group_c >> spaces?).as(:group)
      end

      rule(:group_c) do
        str("group") | str("grou") | str("gro")
      end

      # follow_self & follow
      #######################################################
      rule(:follow_self) do
        spaces? >> follow_c >> spaces >> str("self") >> spaces? >> str("").as(:follow_self)
      end

      rule(:follow) do
        (spaces? >> follow_c >> spaces >> kword.as(:target) >> spaces?).as(:follow)
      end

      rule(:follow_c) do
        str("follow") | str("follo") | str("foll") | str("fol") | str("fo")
      end

      # directions
      #######################################################
      rule(:direction) do
        spaces? >> (north | east | south | west |  up | down).as(:direction) >> spaces?
      end

      rule(:north) do
        north_c.as(:towards) >> bracketed_emote.maybe >> spaces? >> str("!").as(:bang).maybe >> spaces?
      end

      rule(:east) do
        east_c.as(:towards) >> spaces? >> bracketed_emote.maybe >> spaces? >> str("!").as(:bang).maybe >> spaces?
      end

      rule(:south) do
        south_c.as(:towards) >> spaces? >> bracketed_emote.maybe >> spaces? >> str("!").as(:bang).maybe >> spaces?
      end

      rule(:west) do
        west_c.as(:towards) >> spaces? >> bracketed_emote.maybe >> spaces? >> str("!").as(:bang).maybe >> spaces?
      end

      rule(:up) do
        up_c.as(:towards) >> spaces? >> bracketed_emote.maybe >> spaces? >> str("!").as(:bang).maybe >> spaces?
      end

      rule(:down) do
        down_c.as(:towards) >> spaces? >> bracketed_emote.maybe >> spaces? >> str("!").as(:bang).maybe >> spaces?
      end

      rule(:north_c) do
        (str("north") | str("nort") | str("nor") | str("no") | str("n")) >> str("").as(:north)
      end

      rule(:east_c) do
        (str("east") | str("eas") | str("ea") | str("e")) >> str("").as(:east)
      end

      rule(:south_c) do
        (str("south") | str("sout") | str("sou") | str("so") | str("s")) >> str("").as(:south)
      end

      rule(:west_c) do
        (str("west") | str("wes") | str("we") | str("w")) >> str("").as(:west)
      end

      rule(:up_c) do
        (str("up") | str("u")) >> str("").as(:up)
      end

      rule(:down_c) do
        (str("down") | str("dow") | str("do") | str("d")) >> str("").as(:down)
      end

      # exits
      #######################################################
      rule(:exits) do
        spaces? >> exits_c >> spaces? >> str("").as(:exits)
      end

      rule(:exits_c) do
        str("exits") | str("exit") | str("exi") | str("ex")
      end

      # scan & directed_scan
      #######################################################
      rule(:scan) do
        spaces? >> scan_c >> spaces? >> str("").as(:scan)
      end

      rule(:directed_scan) do
        (spaces? >> scan_c >> spaces >> (north_c | east_c | south_c | west_c | up_c | down_c).as(:direction) >> spaces?).as(:directed_scan)
      end

      rule(:scan_c) do
        str("scan") | str("sca")
      end

      # simple_emote
      #######################################################
      rule(:simple_emote) do
        spaces? >>
        simple_emote_c >>
        spaces >>
        emote_with_speech.as(:simple_emote) >>
        spaces?
      end

      rule(:simple_emote_c) do
        str("emote") | str("emot") | str("emo") | str("em") | str(",")
      end

      # look
      #######################################################
      rule(:look_around) do
        spaces? >> look_c >> str("").as(:look_around) >> spaces?
      end

      rule(:look_at) do
        (spaces? >> look_c >> spaces >> kword.as(:target) >> (spaces? >> str(".") >> str("").as(:ground)).maybe >> spaces?).as(:look_at)
      end

      rule(:look_at_on_another) do
        (spaces? >> look_c >> spaces >> kword.as(:character) >> spaces >> kword.as(:target) >> spaces?).as(:look_at_on_another)
      end

      rule(:look_in) do
        (spaces? >> look_c >> spaces? >> str(".") >> spaces? >> kword.as(:target) >> (spaces? >> str(".") >> str("").as(:ground)).maybe >> spaces?).as(:look_in)
      end

      rule(:look_c) do
        str("look") | str("loo") | str("lo") | str("l")
      end

      # get
      #######################################################
      rule(:get_ground) do
        (spaces? >> get_c >> spaces >> (number.as(:amount) >> spaces).maybe >> kword.as(:target) >> spaces?).as(:get_ground)
      end

      rule(:get_container) do
        (spaces? >> get_c >> spaces >> (number.as(:amount) >> spaces).maybe >> kword.as(:target) >> spaces >> kword.as(:source) >> spaces?).as(:get_container)
      end

      rule(:get_c) do
        str("get") | str("ge") | str("g")
      end

      # drop_all
      #######################################################
      rule(:drop_all) do
        spaces? >> drop_c >> spaces >> str("*") >> spaces? >> str("").as(:drop_all)
      end

      # drop
      #######################################################
      rule(:drop) do
        (spaces? >> drop_c >> spaces >> (number.as(:amount) >> spaces).maybe >> kword.as(:target) >> spaces?).as(:drop)
      end

      rule(:drop_c) do
        str("drop") | str("dro") | str("dr")
      end

      # give
      #######################################################
      rule(:give) do
        (spaces? >> give_c >> spaces >> (number.as(:amount) >> spaces).maybe >> kword.as(:target) >> spaces? >> kword.as(:receiver) >> spaces?).as(:give)
      end

      rule(:give_c) do
        str("give") | str("giv") | str("gi") | str("g")
      end

      # put
      #######################################################
      rule(:put) do
        (spaces? >> put_c >> spaces >> (number.as(:amount) >> spaces).maybe >> kword.as(:target) >> spaces >> kword.as(:destination) >> (spaces? >> str(".") >> str("").as(:ground)).maybe >> spaces?).as(:put)
      end

      rule(:put_c) do
        str("put") | str("pu") | str("p")
      end

      # empty
      #######################################################
      rule(:empty_on_ground) do
        (spaces? >> empty_c >> spaces >> kword.as(:target) >> spaces?).as(:empty_on_ground)
      end

      rule(:empty_into_another) do
        (spaces? >> empty_c >> spaces >> kword.as(:target) >> spaces >> kword.as(:destination) >> spaces?).as(:empty_into_another)
      end

      rule(:empty_c) do
        str("empty") | str("empt") | str("emp")
      end

      # fill
      #######################################################
      rule(:fill) do
        (spaces? >> fill_c >> spaces >> kword.as(:target) >> spaces >> kword.as(:source) >> (spaces? >> str(".") >> str("").as(:ground)).maybe >> spaces?).as(:fill)
      end

      rule(:fill_c) do
        str("fill") | str("fil") | str("fi")
      end

      # pour
      #######################################################
      rule(:pour) do
        (spaces? >> pour_c >> spaces >> kword.as(:source) >> spaces? >> spaces?).as(:pour)
      end

      rule(:pour_into) do
        (spaces? >> pour_c >> spaces >> kword.as(:source) >> spaces >> kword.as(:target) >> (spaces? >> str(".") >> str("").as(:ground)).maybe >> spaces?).as(:pour_into)
      end

      rule(:pour_c) do
        str("pour") | str("pou") | str("po")
      end

      # fill
      #######################################################
      rule(:fuel) do
        (spaces? >> fuel_c >> spaces >> kword.as(:target) >> spaces >> kword.as(:source) >> spaces?).as(:fuel)
      end

      rule(:fuel_c) do
        str("fuel") | str("fue") | str("fu")
      end

      # simple_news & simple_news_page & news & news_page
      #######################################################
      rule(:simple_news) do
        spaces? >> news_c >> spaces? >> str("").as(:simple_news)
      end

      rule(:simple_news_page) do
        (spaces? >> news_c >> spaces >> number.as(:page) >> spaces?).as(:simple_news_page)
      end

      rule(:news) do
        (spaces? >> news_c >> spaces >> kword.as(:target) >> spaces?).as(:news)
      end

      rule(:news_page) do
        (spaces? >> news_c >> spaces >> kword.as(:target) >> spaces >> number.as(:page) >> spaces?).as(:news_page)
      end

      rule(:news_c) do
        str("news") | str("new") | str("ne")
      end

      # simple_rnews & rnews
      #######################################################
      rule(:simple_rnews) do
        (spaces? >> rnews_c >> spaces >> number.as(:index) >> spaces?).as(:simple_rnews)
      end

      rule(:rnews) do
        (spaces? >> rnews_c >> spaces >> kword.as(:target) >> spaces >> number.as(:index) >> spaces?).as(:rnews)
      end

      rule(:rnews_c) do
        str("rnews") | str("rnew") | str("rne") | str("rn")
      end

      # read
      #######################################################
      rule(:read) do
        (spaces? >> read_c >> spaces >> kword.as(:target) >> spaces?).as(:read)
      end

      rule(:read_c) do
        str("read") | str("rea")
      end

      # turn
      #######################################################
      rule(:turn) do
        (spaces? >> turn_c >> spaces >> kword.as(:target) >> spaces?).as(:turn)
      end

      rule(:turn_c) do
        str("turn") | str("tur") | str("tu")
      end

      # tear
      #######################################################
      rule(:tear) do
        (spaces? >> tear_c >> spaces >> kword.as(:target) >> spaces?).as(:tear)
      end

      rule(:tear_c) do
        str("tear") | str("tea") | str("te")
      end

      # simple_flip & flip
      #######################################################
      rule(:simple_flip) do
        (spaces? >> flip_c >> spaces >> kword.as(:target) >> spaces?).as(:simple_flip)
      end

      rule(:flip) do
        (spaces? >> flip_c >> spaces >> kword.as(:target) >> spaces >> number.as(:page) >> spaces?).as(:flip)
      end

      rule(:flip_c) do
        str("flip") | str("fli") | str("fl")
      end

      # dip
      #######################################################
      rule(:dip_picking) do
        (spaces? >> dip_c >> spaces >> kword.as(:target) >> spaces?).as(:dip_picking)
      end

      rule(:dip_dipping) do
        (spaces? >> dip_c >> spaces >> kword.as(:target) >> spaces >> kword.as(:source) >> spaces?).as(:dip_dipping)
      end

      rule(:dip_c) do
        str("dip") | str("di")
      end

      # title
      #######################################################
      rule(:title) do
        (spaces? >> title_c >> spaces >> kword.as(:target) >> spaces >> speech >> spaces?).as(:title)
      end

      rule(:title_c) do
        str("title") | str("titl") | str("tit")
      end

      # post
      #######################################################
      rule(:post) do
        (spaces? >> post_c >> spaces >> kword.as(:target) >> spaces >> speech >> spaces?).as(:post)
      end

      rule(:post_c) do
        str("post") | str("pos")
      end

      # write
      #######################################################
      rule(:write) do
        (spaces? >> write_c >> spaces >> kword.as(:target) >> spaces?).as(:write)
      end

      rule(:write_c) do
        str("write") | str("writ") | str("wri") | str("wr")
      end

      # wipe
      #######################################################
      rule(:wipe) do
        (spaces? >> wipe_c >> spaces >> kword.as(:target) >> spaces?).as(:wipe)
      end

      rule(:wipe_c) do
        str("wipe") | str("wip")
      end

      # die
      #######################################################
      rule(:die) do
        (spaces? >> die_c >> spaces?).as(:die)
      end

      rule(:die_c) do
        str("die")
      end
    end
  end
end
