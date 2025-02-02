-------------------------------------------------------------------------------------------------------------------
-- Setup functions for this job.  Generally should not be modified.
-------------------------------------------------------------------------------------------------------------------
-- <slot01>cocoon</slot01> def - crawlers
-- <slot02>tail slap</slot02>  stp - merrows arrapago reef
-- <slot03>sickle slash</slot03> - STP - spiders aby mis coast
-- <slot04>diffusion ray</slot04> STP bonus - Chariots aby uleguerand #07
-- <slot05>anvil lightning</slot05> ACC bonus -  Escalent (ungeweder type = green/blue)
-- <slot06>empty thrash</slot06> Da/Ta - craver promy mea
-- <slot07>erratic flutter</slot07>
-- <slot08>fantod</slot08> - stp (also attack buff) - hippogryph in risenjima
-- <slot09>delta thrust</slot09> DW - peiste in aby mis coast #07
-- <slot10>white wind</slot10> regen trait - puk (Waugyl) in aby altepa
-- <slot11>barrier tusk</slot11> DT - olyphant aby uleguerant 
-- <slot12>nat. meditation</slot12> acc bonus (attk boost when used) - chapuli in risenjima
-- <slot13>sudden lunge</slot13> stp - ladybug aby altepa #01 or #03
-- <slot14>thrashing assault</slot14>
-- <slot15>vanity dive</slot15>
-- <slot16>barbed crescent</slot16>
-- <slot17>disseverment</slot17>
-- <slot18>molting plumage</slot18>
-- <slot19>occultation</slot19>
-- <slot20>heavy strike</slot20>
-- Initialization function for this job file.
function get_sets()
    mote_include_version = 2
    
    -- Load and initialize the include file.
    include('Mote-Include.lua')
	include('organizer-lib')
end


-- Setup vars that are user-independent.  state.Buff vars initialized here will automatically be tracked.
function job_setup()
    state.Buff['Burst Affinity'] = buffactive['Burst Affinity'] or false
    state.Buff['Chain Affinity'] = buffactive['Chain Affinity'] or false
    state.Buff.Convergence = buffactive.Convergence or false
    state.Buff.Diffusion = buffactive.Diffusion or false
    state.Buff.Efflux = buffactive.Efflux or false
    
    state.Buff['Unbridled Learning'] = buffactive['Unbridled Learning'] or false
    state.SkillMode = M{['description']='Skill Mode', 'Normal', 'On'}
    
    include('Mote-TreasureHunter')
    state.TreasureMode = {ammo="Per. Lucky Egg",
    head="Volte Cap",
    hands="Volte Bracers",
    waist="Chaac Belt",}

    state.HasteMode = M{['description']='Haste Mode', 'Normal', 'Hi', 'Trust'}

    blue_magic_maps = {}
    
    -- Mappings for gear sets to use for various blue magic spells.
    -- While Str isn't listed for each, it's generally assumed as being at least
    -- moderately signficant, even for spells with other mods.
    -- Physical Spells --
    
    -- Physical spells with no particular (or known) stat mods
    blue_magic_maps.Physical = S{
        'Bilgestorm'
    }

    -- Spells with heavy accuracy penalties, that need to prioritize accuracy first.
    blue_magic_maps.PhysicalAcc = S{
        'Heavy Strike',
    }

    -- Physical spells with Str stat mod
    blue_magic_maps.PhysicalStr = S{
        'Battle Dance','Bloodrake','Death Scissors','Dimensional Death',
        'Empty Thrash','Quadrastrike','Sinker Drill','Spinal Cleave',
        'Uppercut','Vertical Cleave', 'Quadratic Continuum'
    }
        
    -- Physical spells with Dex stat mod
    blue_magic_maps.PhysicalDex = S{
        'Amorphic Spikes','Asuran Claws','Barbed Crescent','Claw Cyclone','Disseverment',
        'Foot Kick','Frenetic Rip','Goblin Rush','Hysteric Barrage','Paralyzing Triad',
        'Seedspray','Sickle Slash','Smite of Rage','Terror Touch','Thrashing Assault',
        'Vanity Dive'
    }
        
    -- Physical spells with Vit stat mod
    blue_magic_maps.PhysicalVit = S{
        'Body Slam','Cannonball','Delta Thrust','Glutinous Dart','Grand Slam',
        'Power Attack','Quad. Continuum','Sprout Smack','Sub-zero Smash',
        'Sweeping Gouge'
    }
        
    -- Physical spells with Agi stat mod
    blue_magic_maps.PhysicalAgi = S{
        'Benthic Typhoon','Feather Storm','Helldive','Hydro Shot','Jet Stream',
        'Pinecone Bomb','Spiral Spin','Wild Oats'
    }

    -- Physical spells with Int stat mod
    blue_magic_maps.PhysicalInt = S{
        'Mandibular Bite','Queasyshroom'
    }

    -- Physical spells with Mnd stat mod
    blue_magic_maps.PhysicalMnd = S{
        'Ram Charge','Screwdriver','Tourbillion'
    }

    -- Physical spells with Chr stat mod
    blue_magic_maps.PhysicalChr = S{
        'Bludgeon'
    }

    -- Physical spells with HP stat mod
    blue_magic_maps.PhysicalHP = S{
        'Final Sting'
    }

    -- Magical Spells --

    -- Magical spells with the typical Int mod
    blue_magic_maps.Magical = S{
        'Blastbomb','Blazing Bound','Bomb Toss','Cursed Sphere','Dark Orb','Death Ray',
        'Diffusion Ray','Droning Whirlwind','Embalming Earth','Firespit','Foul Waters',
        'Ice Break','Leafstorm','Maelstrom','Rail Cannon','Regurgitation','Rending Deluge',
        'Retinal Glare','Subduction','Tem. Upheaval','Water Bomb', 'Tenebral Crush', 'Spectral Floe',
        'Molting Plumage', 'Searing Tempest'
    }

    blue_magic_maps.MagicalLight = S{
        'Blinding Fulgor'
    }
    -- Magical spells with a primary Mnd mod
    blue_magic_maps.MagicalMnd = S{
        'Acrid Stream','Evryone. Grudge','Magic Hammer','Mind Blast','Scouring Spate'
    }

    -- Magical spells with a primary Chr mod
    blue_magic_maps.MagicalChr = S{
        'Eyes On Me','Mysterious Light'
    }

    -- Magical spells with a Vit stat mod (on top of Int)
    blue_magic_maps.MagicalVit = S{
        'Thermal Pulse', 'Entomb'
    }

    blue_magic_maps.MagicalAgi = S{
        'Silent Storm'
    }

    -- Magical spells with a Dex stat mod (on top of Int)
    blue_magic_maps.MagicalDex = S{
        'Charged Whisker','Gates of Hades','Anvil Lightning'
    }
            
    -- Magical spells (generally debuffs) that we want to focus on magic accuracy over damage.
    -- Add Int for damage where available, though.
    blue_magic_maps.MagicAccuracy = S{
        '1000 Needles','Absolute Terror','Actinic Burst','Auroral Drape','Awful Eye',
        'Blank Gaze','Blistering Roar','Blood Drain','Blood Saber','Chaotic Eye',
        'Cimicine Discharge','Cold Wave','Corrosive Ooze','Demoralizing Roar','Digest',
        'Dream Flower','Enervation','Feather Tickle','Filamented Hold','Frightful Roar',
        'Geist Wall','Hecatomb Wave','Infrasonics','Jettatura','Light of Penance',
        'Lowing','Mind Blast','Mortal Ray','MP Drainkiss','Osmosis','Reaving Wind',
        'Sandspin','Sandspray','Sheep Song','Soporific','Sound Blast','Stinking Gas',
        'Sub-zero Smash','Venom Shell','Voracious Trunk','Yawn'
    }
        
    -- Breath-based spells
    blue_magic_maps.Breath = S{
        'Bad Breath','Flying Hip Press','Frost Breath','Heat Breath',
        'Hecatomb Wave','Magnetite Cloud','Poison Breath','Radiant Breath','Self-Destruct',
        'Thunder Breath','Vapor Spray','Wind Breath'
    }

    -- Stun spells
    blue_magic_maps.Stun = S{
        'Blitzstrahl','Frypan','Head Butt','Sudden Lunge','Tail slap','Temporal Shift',
        'Thunderbolt','Whirl of Rage'
    }
        
    -- Healing spells
    blue_magic_maps.Healing = S{
        'Healing Breeze','Magic Fruit','Plenilune Embrace','Pollen','Restoral','White Wind',
        'Wild Carrot'
    }
    
    -- Buffs that depend on blue magic skill
    blue_magic_maps.SkillBasedBuff = S{
        'Barrier Tusk','Diamondhide','Magic Barrier','Metallic Body','Plasma Charge',
        'Pyric Bulwark','Reactor Cool','Nat. Meditation'
    }

    -- Other general buffs
    blue_magic_maps.Buff = S{
        'Amplification','Animating Wail','Battery Charge','Carcharian Verve','Cocoon',
        'Erratic Flutter','Exuviation','Fantod','Feather Barrier','Harden Shell',
        'Memento Mori','Nat. Meditation','Occultation','Orcish Counterstance','Refueling',
        'Regeneration','Saline Coat','Triumphant Roar','Warm-Up','Winds of Promyvion',
        'Zephyr Mantle'
    }
    
    
    -- Spells that require Unbridled Learning to cast.
    unbridled_spells = S{
        'Absolute Terror','Bilgestorm','Blistering Roar','Bloodrake','Carcharian Verve',
        'Crashing Thunder','Droning Whirlwind','Gates of Hades','Harden Shell','Polar Roar',
        'Pyric Bulwark','Thunderbolt','Tourbillion','Uproot'
    }
    -- For th_action_check():
    -- JA IDs for actions that always have TH: Provoke, Animated Flourish
    info.default_ja_ids = S{35, 204}
    -- Unblinkable JA IDs for actions that always have TH: Quick/Box/Stutter Step, Desperate/Violent Flourish
    info.default_u_ja_ids = S{201, 202, 203, 205, 207}
end

-------------------------------------------------------------------------------------------------------------------
-- User setup functions for this job.  Recommend that these be overridden in a sidecar file.
-------------------------------------------------------------------------------------------------------------------

-- Setup vars that are user-dependent.  Can override this function in a sidecar file.
function user_setup()
    state.OffenseMode:options('Normal', 'Mid', 'Acc', 'Learning')
    state.HybridMode:options('Normal', 'PDT', 'EVA')
    state.WeaponskillMode:options('Normal', 'Acc')
    state.CastingMode:options('Normal', 'Resistant')
    state.IdleMode:options('Normal', 'PDT', 'Learning')

    -- Additional local binds
    send_command('bind ^= gs c cycle treasuremode')
    send_command('bind ^` input /ja "Chain Affinity" <me>')
    send_command('bind !` input /ja "Efflux" <me>')
    send_command('bind @` input /ja "Burst Affinity" <me>')
    send_command('bind @f9 gs c cycle HasteMode')
    send_command('bind @= gs c cycle SkillMode')

    update_combat_form()
    select_default_macro_book()
end


-- Called when this job file is unloaded (eg: job change)
function user_unload()
    send_command('unbind ^`')
    send_command('unbind !`')
    send_command('unbind @`')
    send_command('unbind @f9')
end


-- Set up gear sets.
function init_gear_sets()
    --------------------------------------
    -- Start defining the sets
    --------------------------------------

    HercFeet = {}
    HercHead = {}
    HercLegs = {}
    HercHands = {}
    HercBody = {}

    HercHands.R = { name="Herculean Gloves", augments={'VIT+5','Pet: INT+7','"Refresh"+2','Mag. Acc.+8 "Mag.Atk.Bns."+8',}}
    HercHands.MAB = { name="Herculean Gloves", augments={'Mag. Acc.+20 "Mag.Atk.Bns."+20','Crit.hit rate+1','STR+6','Mag. Acc.+5','"Mag.Atk.Bns."+12',}}
    HercHands.WSD = { name="Herculean Gloves", augments={'Accuracy+23 Attack+23','Weapon skill damage +3%','STR+10','Accuracy+10','Attack+1',}}
    
    HercFeet.MAB = { name="Herculean Boots", augments={'Mag. Acc.+30','"Mag.Atk.Bns."+25','Accuracy+3 Attack+3','Mag. Acc.+12 "Mag.Atk.Bns."+12',}}
    HercFeet.TP = { name="Herculean Boots", augments={'Accuracy+21 Attack+21','"Triple Atk."+4','DEX+8',}}
    
    HercBody.MAB = { name="Herculean Vest", augments={'Haste+1','"Mag.Atk.Bns."+27','Mag. Acc.+19 "Mag.Atk.Bns."+19',}}
    HercBody.WSD = { name="Herculean Vest", augments={'"Blood Pact" ability delay -4','AGI+3','Weapon skill damage +9%','Mag. Acc.+4 "Mag.Atk.Bns."+4',}}
    
    HercHead.MAB = {name="Herculean Helm", augments={'Mag. Acc.+19 "Mag.Atk.Bns."+19','Weapon skill damage +3%','INT+1','Mag. Acc.+3','"Mag.Atk.Bns."+8',}}
    HercHead.TP = { name="Herculean Helm", augments={'Accuracy+25','"Triple Atk."+4','AGI+6','Attack+14',}}
    HercHead.DM = { name="Herculean Helm", augments={'Pet: STR+9','Mag. Acc.+10 "Mag.Atk.Bns."+10','Weapon skill damage +9%','Accuracy+12 Attack+12',}}

    HercLegs.MAB = { name="Herculean Trousers", augments={'Mag. Acc.+20 "Mag.Atk.Bns."+20','INT+10','Mag. Acc.+15','"Mag.Atk.Bns."+14',}}
    HercLegs.TH = { name="Herculean Trousers", augments={'Phys. dmg. taken -1%','VIT+10','"Treasure Hunter"+2','Accuracy+10 Attack+10','Mag. Acc.+19 "Mag.Atk.Bns."+19',}} 

    Rosmerta = {}
    Rosmerta.TP = {name="Rosmerta's Cape", augments={'DEX+20','Accuracy+20 Attack+20','"Dbl.Atk."+10','Phys. dmg. taken-10%',}}
    Rosmerta.WS = {name="Rosmerta's Cape", augments={'STR+20','Accuracy+20 Attack+20','STR+10','Weapon skill damage +10%',}}

    sets.buff['Burst Affinity'] = { legs="Assimilator's Shalwar +1" }
    sets.buff['Chain Affinity'] = {
        --head="Mavi Kavuk +2", 
        feet="Assimilator's Charuqs +1"
    }
    -- sets.buff.Convergence = {head="Luhlaza Keffiyeh"}
    sets.buff.Diffusion = {feet="Luhlaza Charuqs"}
    -- sets.buff.Enchainment = {body="Luhlaza Jubbah"}
    -- sets.buff.Efflux = {legs="Mavi Tayt +2"}
    
    -- Precast Sets
    
    -- Precast sets to enhance JAs
    --sets.precast.JA['Azure Lore'] = {hands="Mirage Bazubands +2"}
    sets.precast.JA['Efflux'] = {back="Rosmerta's Cape"}

    -- Waltz set (chr and vit)
    sets.precast.Waltz = {}
        
    -- Don't need any special gear for Healing Waltz.
    sets.precast.Waltz['Healing Waltz'] = {}

    -- Fast cast sets for spells
    sets.TreasureHunter = {head="White rarab cap +1", waist="Chaac Belt", legs=HercLegs.TH}
    
    sets.precast.FC = {
        head={ name="Carmine Mask", augments={'Accuracy+15','Mag. Acc.+10','"Fast Cast"+3',}},
    body="Dread Jupon",
    hands={ name="Leyline Gloves", augments={'Accuracy+15','Mag. Acc.+15','"Mag.Atk.Bns."+15','"Fast Cast"+3',}},
    legs={ name="Lengo Pants", augments={'INT+10','Mag. Acc.+15','"Mag.Atk.Bns."+15','"Refresh"+1',}},
    waist="Witful Belt",
    right_ear="Loquac. Earring",
    left_ring="Weather. Ring",
    right_ring="Kishar Ring",
    }
        
    --sets.precast.FC['Blue Magic'] = set_combine(sets.precast.FC, {body="Mavi Mintan +2"})
       
    -- Weaponskill sets
    -- Default set for any weaponskill that isn't any more specifically defined
    sets.precast.WS = {
        ammo="Aurgelmir Orb +1",
    head="Nyame Helm",
    body="Nyame Mail",
    hands={ name="Nyame Gauntlets", augments={'Path: B',}},
    legs={ name="Herculean Trousers", augments={'Rng.Acc.+14','DEX+8','Weapon skill damage +9%',}},
    feet={ name="Herculean Boots", augments={'AGI+6','Pet: Haste+1','Weapon skill damage +6%','Accuracy+16 Attack+16',}},
    neck={ name="Mirage Stole +2", augments={'Path: A',}},
    waist="Windbuffet Belt +1",
    left_ear="Ishvara Earring",
    right_ear="Brutal Earring",
    left_ring="Ilabrat Ring",
    right_ring="Epaminondas's Ring",
    back={ name="Rosmerta's Cape", augments={'INT+20','Mag. Acc+20 /Mag. Dmg.+20','INT+10','"Mag.Atk.Bns."+10',}},
    }

    sets.precast.WS['Chant du Cygne'] = set_combine(sets.precast.WS, {
        ammo="Aurgelmir Orb +1",
    head={ name="Blistering Sallet +1", augments={'Path: A',}},
    body={ name="Gleti's Cuirass", augments={'Path: A',}},
    hands={ name="Nyame Gauntlets", augments={'Path: B',}},
    legs={ name="Samnuha Tights", augments={'STR+10','DEX+10','"Dbl.Atk."+3','"Triple Atk."+3',}},
    feet="Gleti's Boots",
    neck={ name="Mirage Stole +2", augments={'Path: A',}},
    waist="Gerdr Belt",
    left_ear="Odr Earring",
    right_ear={ name="Moonshade Earring", augments={'Accuracy+4','TP Bonus +250',}},
    left_ring="Ilabrat Ring",
    right_ring="Petrov Ring",
    back={ name="Rosmerta's Cape", augments={'INT+20','Mag. Acc+20 /Mag. Dmg.+20','INT+10','"Mag.Atk.Bns."+10',}},
}
    )
    sets.precast.WS['Chant du Cygne'].Mid = set_combine(sets.precast.WS['Chant du Cygne'], {
        feet="Ayanmo Gambieras +2"
    })
    sets.precast.WS['Savage Blade'] = set_combine(sets.precast.WS, {
        ammo="Aurgelmir Orb +1",
    head={ name="Herculean Helm", augments={'Accuracy+10','Weapon skill damage +5%','Attack+3',}},
    body={ name="Herculean Vest", augments={'Accuracy+18 Attack+18','Weapon skill damage +4%','STR+6',}},
    hands={ name="Nyame Gauntlets", augments={'Path: B',}},
    legs={ name="Nyame Flanchard", augments={'Path: B',}},
    feet={ name="Herculean Boots", augments={'AGI+6','Pet: Haste+1','Weapon skill damage +6%','Accuracy+16 Attack+16',}},
    neck={ name="Mirage Stole +2", augments={'Path: A',}},
    waist="Prosilio Belt +1",
    left_ear={ name="Moonshade Earring", augments={'Accuracy+4','TP Bonus +250',}},
    right_ear={ name="Hashishin Earring", augments={'System: 1 ID: 1676 Val: 0','Accuracy+6','Mag. Acc.+6',}},
    left_ring="Sroda Ring",
    right_ring="Epaminondas's Ring",
    back={ name="Rosmerta's Cape", augments={'INT+20','Mag. Acc+20 /Mag. Dmg.+20','INT+10','"Mag.Atk.Bns."+10',}},

    })
    sets.precast.WS['Savage Blade'].Mid = set_combine(sets.precast.WS, {
    })
    sets.precast.WS['Savage Blade'].Acc = set_combine(sets.precast.WS.Mid, {
        body="Adhemar Jacket +1",
    })
    
    sets.precast.WS.acc = set_combine(sets.precast.WS, {})

    -- Specific weaponskill sets.  Uses the base set if an appropriate WSMod version isn't found.
    sets.precast.WS['Requiescat'] = set_combine(sets.precast.WS, {
        ammo="Coiste Bodhar",
    head={ name="Adhemar Bonnet +1", augments={'DEX+12','AGI+12','Accuracy+20',}},
    body={ name="Gleti's Cuirass", augments={'Path: A',}},
    hands={ name="Herculean Gloves", augments={'Accuracy+23 Attack+23','"Triple Atk."+4','Attack+12',}},
    legs={ name="Samnuha Tights", augments={'STR+10','DEX+10','"Dbl.Atk."+3','"Triple Atk."+3',}},
    feet={ name="Herculean Boots", augments={'Accuracy+26','"Triple Atk."+2','Attack+9',}},
    neck="Lissome Necklace",
    waist={ name="Sailfi Belt +1", augments={'Path: A',}},
    left_ear={ name="Moonshade Earring", augments={'Accuracy+4','TP Bonus +250',}},
    right_ear={ name="Hashishin Earring", augments={'System: 1 ID: 1676 Val: 0','Accuracy+6','Mag. Acc.+6',}},
    left_ring="Sroda Ring",
    right_ring="Epaminondas's Ring",
    back={ name="Rosmerta's Cape", augments={'INT+20','Mag. Acc+20 /Mag. Dmg.+20','INT+10','"Mag.Atk.Bns."+10',}},
})

    sets.precast.WS['Sanguine Blade'] = {
        ammo="Coiste Bodhar",
        head="Pixie Hairpin +1",
        body={ name="Herculean Vest", augments={'MND+8','Weapon skill damage +9%','Accuracy+14 Attack+14','Mag. Acc.+11 "Mag.Atk.Bns."+11',}},
        hands={ name="Nyame Gauntlets", augments={'Path: B',}},
        legs={ name="Nyame Flanchard", augments={'Path: B',}},
        feet="Nyame Sollerets",
        neck="Sanctity Necklace",
        waist="Orpheus's Sash",
        left_ear="Hermetic Earring",
        right_ear="Friomisi Earring",
        left_ring="Shiva Ring +1",
        right_ring="Archon Ring",
        back={ name="Rosmerta's Cape", augments={'INT+20','Mag. Acc+20 /Mag. Dmg.+20','INT+10','"Mag.Atk.Bns."+10',}},
    }
   
    
    
    -- Midcast Sets
    sets.midcast.FastRecast = {
        ammo="Staunch Tathlum",
        head=HercHead.MAB,
        ear2="Loquacious Earring",
        --body="Luhlaza Jubbah",
        --hands="Mavi Bazubands +2",
        ring1="Weatherspoon Ring",
        legs="Lengo Pants",
        waist="Sailfi Belt +1",
    }

    sets.midcast['Dark Magic'] = {
        ammo="Pemphredo Tathlum",
        head="Pixie Hairpin +1",
        body="Shamash Robe",
        hands="Jhakri Cuffs +2",
        legs="Jhakri Slops +2",
        feet="Jhakri Pigaches +2",
        neck="Erra Pendant",
        waist="Eschan Stone",
        ear1="Crepuscular Earring",
        ear2="Regal Earring",
        left_ring="Evanescence Ring",
        right_ring="Weather. Ring",
        back="Aput Mantle",
    }
    sets.midcast.Drain = set_combine(sets.midcast['Dark Magic'], {
        waist="Fucho-no-Obi",
    })
    sets.midcast.Aspir = sets.midcast.Drain
        
    sets.midcast['Blue Magic'] = {
        neck="Mirage Stole +1",
        body="Assimilator's Jubbah +1",
        back="Cornflower Cape",
        -- legs="Mavi Tayt +2",
        feet="Luhlaza Charuqs"
    }
    
    -- Physical Spells --
    
    sets.midcast['Blue Magic'].Physical = {
        ammo="Coiste Bodhar",
        head="Adhemar Bonnet +1",
        neck="Mirage Stole +1",
        --ear1="Flame Pearl",
        --ear2="Flame Pearl",
        body="Adhemar Jacket +1",
        hands="Adhemar Wristbands +1",
        ring1="Ilabrat Ring",
        ring2="Rajas Ring",
        back=Rosmerta.WS,
        waist="Metalsinger Belt",
        legs="Jhakri Slops +2",
        feet=HercFeet.TP
    }

    sets.midcast['Blue Magic'].PhysicalAcc = set_combine(sets.midcast['Blue Magic'].Physical, {
        head="Malignance Chapeau",
        body="Malignance Tabard",
        ear1="Telos Earring",
        ring1="Cacoethic Ring +1",
        legs="Malignance Tights", 
    })

    sets.midcast['Blue Magic'].PhysicalStr = set_combine(sets.midcast['Blue Magic'].Physical, {
        ring2="Ifrit Ring"
    })

    sets.midcast['Blue Magic'].PhysicalDex = set_combine(sets.midcast['Blue Magic'].Physical, {
        ear1="Odr Earring",
        head="Malignance Chapeau",
        legs="Samnuha Tights"
    })

    sets.midcast['Blue Magic'].PhysicalVit = set_combine(sets.midcast['Blue Magic'].Physical, {})

    sets.midcast['Blue Magic'].PhysicalAgi = set_combine(sets.midcast['Blue Magic'].Physical, {})

    sets.midcast['Blue Magic'].PhysicalInt = set_combine(sets.midcast['Blue Magic'].Physical, {})

    sets.midcast['Blue Magic'].PhysicalMnd = set_combine(sets.midcast['Blue Magic'].Physical, {})

    sets.midcast['Blue Magic'].PhysicalChr = set_combine(sets.midcast['Blue Magic'].Physical, {})

    sets.midcast['Blue Magic'].PhysicalHP = set_combine(sets.midcast['Blue Magic'].Physical)


    -- Magical Spells --
    sets.midcast['Blue Magic'].Magical = {
        ammo="Pemphredo Tathlum",
        --head=HercHead.MAB,
        head="White rarab cap +1",
        neck="Eddy Necklace",
        ear1="Friomisi Earring",
        ear2="Regal Earring",
        body="Shamash Robe",
        hands="Jhakri Cuffs +2",
        ring1="Shiva Ring",
        ring2="Shiva Ring",
        back="Cornflower Cape",
        --waist="Yamabuki-no-Obi",
        waist="Chaac Belt",
        legs=HercLegs.TH,
        feet="Jhakri Pigaches +2"
    }

    sets.midcast['Blue Magic'].Magical.Resistant = set_combine(sets.midcast['Blue Magic'].Magical, {
        neck="Mirage Stole +1",
    })
    
    sets.midcast['Blue Magic'].MagicalLight = set_combine(sets.midcast['Blue Magic'].Magical, {
        ring1="Weatherspoon Ring"
    })
    sets.midcast['Blue Magic'].MagicalMnd = set_combine(sets.midcast['Blue Magic'].Magical, {})

    sets.midcast['Blue Magic'].MagicalAgi = set_combine(sets.midcast['Blue Magic'].Magical, {
        head="Malignance Chapeau",
        legs=HercLegs.MAB,
        ring1="Rajas Ring",
        ring2="Ilabrat Ring",
        feet=HercFeet.MAB
    })

    sets.midcast['Blue Magic'].MagicalChr = set_combine(sets.midcast['Blue Magic'].Magical)

    sets.midcast['Blue Magic'].MagicalVit = set_combine(sets.midcast['Blue Magic'].Magical, {})

    sets.midcast['Blue Magic'].MagicalDex = set_combine(sets.midcast['Blue Magic'].Magical, {
        head="Malignance Chapeau",
        ring1="Ilabrat Ring"
    })

    sets.midcast['Blue Magic'].MagicAccuracy = set_combine(sets.midcast['Blue Magic'].Magical, {
        head="Malignance Chapeau",
        neck="Mirage Stole +1",
        back="Aput Mantle",
        ring1="Weatherspoon Ring",
        ring2="Crepuscular Ring",
        legs="Malignance Tights", 
    })

    -- Breath Spells --
    
    sets.midcast['Blue Magic'].Breath = set_combine(sets.midcast['Blue Magic'].MagicAccuracy, {
        ammo="Mavi Tathlum",
        -- head="Luhlaza Keffiyeh",
        neck="Mirage Stole +1",
        -- ear1="Lifestorm Earring",
        -- ear2="Psystorm Earring",
        -- body="Vanir Cotehardie",
        -- hands="Assimilator's Bazubands +1",
        -- ring1="K'ayres Ring",
        -- ring2="Beeline Ring",
        -- back="Refraction Cape",
        waist="Glassblower's Belt",
        -- legs="Enif Cosciales",
        feet="Malignance Boots"
    })

    -- Other Types --
    
    sets.midcast['Blue Magic'].Stun = set_combine(sets.midcast['Blue Magic'].MagicAccuracy,
        {waist="Chaac Belt"})
        
    sets.midcast['Blue Magic']['Tenebral Crush'] = set_combine(sets.midcast['Blue Magic'].Magical, {
        head="Pixie Hairpin +1"
     })

    sets.midcast['Blue Magic'].Healing = set_combine(sets.midcast['Blue Magic'].MagicAccuracy, {
        ammo="Staunch Tathlum",
    head={ name="Luhlaza Keffiyeh", augments={'Enhances "Convergence" effect',}},
    body={ name="Telchine Chas.", augments={'Pet: "Regen"+3','Pet: Damage taken -3%',}},
    hands="Jhakri Cuffs +2",
    legs={ name="Lengo Pants", augments={'INT+9','Mag. Acc.+15','"Mag.Atk.Bns."+14',}},
    feet="Malignance Boots",
    neck="Phalaina Locket",
    waist="Bishop's Sash",
    left_ear="Regal Earring",
    right_ear="Friomisi Earring",
    left_ring="Sirona's Ring",
    right_ring="Weather. Ring",
    back={ name="Rosmerta's Cape", augments={'INT+20','Mag. Acc+20 /Mag. Dmg.+20','INT+10','"Mag.Atk.Bns."+10',}},
})

    sets.midcast['Blue Magic'].SkillBasedBuff = {
        head={ name="Luhlaza Keffiyeh", augments={'Enhances "Convergence" effect',}},
    feet={ name="Luhlaza Charuqs", augments={'Enhances "Diffusion" effect',}},
    neck={ name="Mirage Stole +2", augments={'Path: A',}},
    right_ear={ name="Hashishin Earring", augments={'System: 1 ID: 1676 Val: 0','Accuracy+6','Mag. Acc.+6',}},
    back={ name="Cornflower Cape", augments={'MP+18','DEX+2','Accuracy+1','Blue Magic skill +6',}},
}
    

    sets.midcast.Refresh = set_combine(sets.midcast['Blue Magic'].MagicAccuracy, {
        head="Amalric Coif"
    })
    sets.midcast['Blue Magic'].Buff = set_combine(sets.midcast['Blue Magic'].MagicAccuracy, {
        ammo="Mavi Tathlum",
        neck="Mirage Stole +1",
        body="Assimilator's Jubbah +1",
        feet="Luhlaza Charuqs",
        back="Cornflower Cape",
    })
    sets.midcast['Blue Magic']['Battery Charge'] = set_combine(sets.midcast['Blue Magic'].Buff, {
        head="Amalric Coif"
    })
    sets.midcast['Blue Magic']['Diamondhide'] = set_combine(sets.midcast['Blue Magic'].Buff, {
        waist="Siegel Sash",
    })
    sets.midcast.Aquaveil = sets.midcast['Blue Magic']['Battery Charge']
    
    -- sets.midcast.Protect = {ring1="Sheltered Ring"}
    -- sets.midcast.Protectra = {ring1="Sheltered Ring"}
    -- sets.midcast.Shell = {ring1="Sheltered Ring"}
    -- sets.midcast.Shellra = {ring1="Sheltered Ring"}

    -- Sets to return to when not performing an action.

    -- Gear for learning spells: +skill and AF hands.
    sets.Learning = {
        -- ammo="Mavi Tathlum",
        -- head="Mirage Keffiyeh",
        -- neck="Incanter's Torque",
        -- body="Assimilator's Jubbah +1",
        hands="Assimilator's Bazubands +1"
    }
        --head="Luhlaza Keffiyeh",  
        --body="Assimilator's Jubbah",hands="Assimilator's Bazubands +1",
        --back="Cornflower Cape",legs="Mavi Tayt +2",feet="Luhlaza Charuqs"}


    sets.latent_refresh = {
        body="Jhakri Robe +2",
        waist="Fucho-no-obi"
    }

    -- Resting sets
    sets.resting = {
        ammo="Staunch Tathlum",
        neck="Sanctity Necklace",
        body="Shamash Robe",
        hands=HercHands.R,
        ring1="Defending Ring",
        ring2="Paguroidea Ring",
        waist="Flume Belt",
        back="Kumbira Cape",
        feet="Malignance Boots"
    }
    
    -- Idle sets
    sets.idle = {
        ammo="Staunch Tathlum",
        head="Rawhide Mask",
        neck="Sanctity Necklace",
        ear1="Infused Earring",
        ear2="Etiolation Earring",
        body="Shamash Robe",
        hands=HercHands.R,
        ring1="Defending Ring",
        ring2="Paguroidea Ring",
        waist="Flume Belt",
        legs="Carmine Cuisses +1",
        back="Kumbira Cape",
        feet="Malignance Boots"
    }

    sets.idle.PDT = set_combine(sets.idle, {
        head="Malignance Chapeau",
        neck="Twilight Torque",
        ring1="Defending Ring",
        hands="Malignance Gloves",
        body="Malignance Tabard",
        legs="Malignance Tights", 
        feet="Malignance Boots"
    })

    sets.idle.Town = set_combine(sets.idle, {
        neck="Mirage Stole +1",
        head="Malignance Chapeau",
        hands="Malignance Gloves",
        body="Malignance Tabard",
        ear1="Telos Earring",
        ear2="Regal Earring",
        ring1="Defending Ring",
        ring2="Ilabrat Ring",
        back=Rosmerta.TP
    })

    sets.idle.Learning = set_combine(sets.idle, sets.Learning)

    sets.idle.Refresh = set_combine(sets.idle.Regen, {
    })
    
    -- Defense sets
    sets.defense.PDT = { }

    sets.defense.MDT = {}

    sets.Kiting = {legs="Carmine Cuisses +1"}

    -- Engaged sets

    -- Variations for TP weapon and (optional) offense/defense modes.  Code will fall back on previous
    -- sets if more refined versions aren't defined.
    -- If you create a set with both offense and defense modes, the offense mode should be first.
    -- EG: sets.engaged.Dagger.Accuracy.Evasion
    
    -- Normal melee group
    sets.engaged = {
        ammo="Coiste Bodhar",
    head={ name="Adhemar Bonnet +1", augments={'DEX+12','AGI+12','Accuracy+20',}},
    body={ name="Gleti's Cuirass", augments={'Path: A',}},
    hands={ name="Herculean Gloves", augments={'Accuracy+23 Attack+23','"Triple Atk."+4','Attack+12',}},
    legs="Gleti's Breeches",
    feet={ name="Herculean Boots", augments={'Accuracy+26','"Triple Atk."+2','Attack+9',}},
    neck={ name="Mirage Stole +2", augments={'Path: A',}},
    waist={ name="Sailfi Belt +1", augments={'Path: A',}},
    left_ear="Telos Earring",
    right_ear="Digni. Earring",
    left_ring="Ilabrat Ring",
    right_ring="Petrov Ring",
    back={ name="Cornflower Cape", augments={'MP+18','DEX+2','Accuracy+1','Blue Magic skill +6',}},
}
    

    sets.engaged.Mid = set_combine(sets.engaged, {
        head="Adhemar Bonnet +1",
        --legs=HercLegs.TP,
        neck="Mirage Stole +1",
    })

    sets.engaged.Acc = set_combine(sets.engaged.Mid, {
        ear1="Telos Earring",
        waist="Olseni Belt",
        ring1="Cacoethic Ring +1",
        legs="Malignance Tights", 
    })

    sets.engaged.PDT = set_combine(sets.engaged, {
        head="Nyame Helm",
        body="Nyame Mail",
        hands="Nyame Gauntlets",
        legs="Nyame Flanchard", 
        feet="Nyame Sollerets",
        neck="Twilight Torque",
        ring1="Defending Ring",
    })
    sets.engaged.EVA = set_combine(sets.engaged, {
        head="Malignance Chapeau",
        body="Malignance Tabard",
        hands="Malignance Gloves",
        legs="Malignance Tights", 
        feet="Malignance Boots",
        neck="Twilight Torque",
        ring1="Defending Ring",
    })
    sets.engaged.Mid.PDT = set_combine(sets.engaged.Mid, {
        head="Nyame Helm",
        body="Nyame Mail",
        hands="Nyame Gauntlets",
        legs="Nyame Flanchard", 
        feet="Nyame Sollerets",
        neck="Twilight Torque",
        ring1="Defending Ring",
        ring2="Patricius Ring",
    })
    sets.engaged.Mid.EVA = set_combine(sets.engaged.Mid, {
        head="Malignance Chapeau",
        body="Malignance Tabard",
        hands="Malignance Gloves",
        legs="Malignance Tights", 
        feet="Malignance Boots",
        neck="Twilight Torque",
        ring1="Defending Ring",
        ring2="Patricius Ring",
    })
    sets.engaged.Acc.PDT = set_combine(sets.engaged.Mid.PDT, {
        head="Nyame Helm",
        body="Nyame Mail",
        hands="Nyame Gauntlets",
        legs="Nyame Flanchard", 
        feet="Nyame Sollerets",
        ring1="Defending Ring",
    })
    sets.engaged.Acc.EVA = set_combine(sets.engaged.Mid.EVA, {
        head="Malignance Chapeau",
        body="Malignance Tabard",
        hands="Malignance Gloves",
        legs="Malignance Tights", 
        feet="Malignance Boots",
        ring1="Defending Ring",
    })

    sets.engaged.Learning = set_combine(sets.engaged, sets.Learning)

    
    sets.engaged.MaxHaste = set_combine(sets.engaged, {
        body="Adhemar Jacket +1",
        ear1="Brutal Earring",
        ear2="Cessance Earring",
        legs="Samnuha Tights",
        waist="Windbuffet Belt +1"
     })
    sets.engaged.Mid.MaxHaste = set_combine(sets.engaged.MaxHaste, {
        ear1="Telos Earring",
        ear2="Cessance Earring",
        --legs=HercLegs.TP
     })
    sets.engaged.Acc.MaxHaste = set_combine(sets.engaged.Mid.MaxHaste, {
        head="Malignance Chapeau",
        ear2="Cessance Earring",
        ring1="Cacoethic Ring +1",
        waist="Olseni Belt",
        legs="Malignance Tights", 
     })
     sets.engaged.Learning.MaxHaste = set_combine(sets.engaged.MaxHaste, sets.Learning)
    
    sets.engaged.EVA.MaxHaste = set_combine(sets.engaged.MaxHaste, {
        ammo="Crepuscular Pebble",
        neck="Twilight Torque",
        head="Malignance Chapeau",
        body="Malignance Tabard",
        hands="Malignance Gloves",
        legs="Malignance Tights",
        ring1="Defending Ring",
        ring2="Patricius Ring",
        feet="Malignance Boots"
    })
    sets.engaged.Mid.EVA.MaxHaste = set_combine(sets.engaged.Mid.MaxHaste, {
        ammo="Crepuscular Pebble",
        neck="Twilight Torque",
        body="Malignance Tabard",
        ring1="Defending Ring",
        ring2="Patricius Ring",
    })
    sets.engaged.Acc.EVA.MaxHaste = set_combine(sets.engaged.Acc.MaxHaste, {
        ammo="Crepuscular Pebble",
        neck="Twilight Torque",
        body="Malignance Tabard",
        ring1="Defending Ring",
        ring2="Patricius Ring",
    })
    
    sets.engaged.PDT.MaxHaste = set_combine(sets.engaged.MaxHaste, {
        ammo="Crepuscular Pebble",
        neck="Twilight Torque",
        head="Nyame Helm",
        body="Nyame Mail",
        hands="Nyame Gauntlets",
        legs="Nyame Flanchard",
        feet="Nyame Sollerets",
        ring1="Defending Ring",
        ring2="Patricius Ring",
    })
    sets.engaged.Mid.PDT.MaxHaste = set_combine(sets.engaged.Mid.MaxHaste, {
        head="Nyame Helm",
        body="Nyame Mail",
        hands="Nyame Gauntlets",
        legs="Nyame Flanchard",
        feet="Nyame Sollerets",
        ammo="Crepuscular Pebble",
        neck="Twilight Torque",
        ring1="Defending Ring",
        ring2="Patricius Ring",
    })
    sets.engaged.Acc.PDT.MaxHaste = set_combine(sets.engaged.Acc.MaxHaste, {
        ammo="Crepuscular Pebble",
        neck="Twilight Torque",
        head="Nyame Helm",
        body="Nyame Mail",
        hands="Nyame Gauntlets",
        legs="Nyame Flanchard",
        feet="Nyame Sollerets",
        ring1="Defending Ring",
        ring2="Patricius Ring",
    })

    sets.engaged.Haste_35 = set_combine(sets.engaged.MaxHaste, {
        ear1="Telos Earring",
        body="Adhemar Jacket +1",
        waist="Windbuffet Belt +1"
    })
    sets.engaged.Mid.Haste_35 = set_combine(sets.engaged.Mid.MaxHaste, {
        ear1="Telos Earring",
        ear2="Brutal Earring",
        waist="Windbuffet Belt +1",
        --legs=HercLegs.TP
    })
    sets.engaged.Acc.Haste_35 = set_combine(sets.engaged.Acc.MaxHaste, {
        head="Malignance Chapeau",
        ear2="Cessance Earring",
        ring1="Cacoethic Ring +1",
        --legs=HercLegs.TP
    })
     sets.engaged.Learning.Haste_35 = set_combine(sets.engaged.Haste_35, sets.Learning)

    sets.engaged.PDT.Haste_35 = set_combine(sets.engaged.Haste_35, {
        ammo="Crepuscular Pebble",
        head="Nyame Helm",
        body="Nyame Mail",
        hands="Nyame Gauntlets",
        legs="Nyame Flanchard",
        feet="Nyame Sollerets",
        neck="Twilight Torque",
        ring1="Defending Ring",
        ring2="Patricius Ring",
    })
    sets.engaged.Mid.PDT.Haste_35 = set_combine(sets.engaged.Mid.Haste_35, {
        ammo="Crepuscular Pebble",
        neck="Twilight Torque",
        ring1="Defending Ring",
        ring2="Patricius Ring",
        head="Nyame Helm",
        body="Nyame Mail",
        hands="Nyame Gauntlets",
        legs="Nyame Flanchard",
        feet="Nyame Sollerets",
    })
    sets.engaged.Acc.PDT.Haste_35 = set_combine(sets.engaged.Acc.Haste_35, {
        ammo="Crepuscular Pebble",
        neck="Twilight Torque",
        ring1="Defending Ring",
        ring2="Patricius Ring",
        head="Nyame Helm",
        body="Nyame Mail",
        hands="Nyame Gauntlets",
        legs="Nyame Flanchard",
        feet="Nyame Sollerets",
    })
    sets.engaged.EVA.Haste_35 = set_combine(sets.engaged.Haste_35, {
        ammo="Crepuscular Pebble",
        head="Malignance Chapeau",
        neck="Twilight Torque",
        ring1="Defending Ring",
        ring2="Patricius Ring",
        hands="Malignance Gloves",
        body="Malignance Tabard",
        legs="Malignance Tights", 
        feet="Malignance Boots"
    })
    sets.engaged.Mid.EVA.Haste_35 = set_combine(sets.engaged.Mid.Haste_35, {
        ammo="Crepuscular Pebble",
        head="Malignance Chapeau",
        neck="Twilight Torque",
        hands="Malignance Gloves",
        ring1="Defending Ring",
        ring2="Patricius Ring",
        body="Malignance Tabard",
        legs="Malignance Tights", 
        feet="Malignance Boots"
    })
    sets.engaged.Acc.EVA.Haste_35 = set_combine(sets.engaged.Acc.Haste_35, {
        ammo="Crepuscular Pebble",
        head="Malignance Chapeau",
        neck="Twilight Torque",
        ring1="Defending Ring",
        ring2="Patricius Ring",
        hands="Malignance Gloves",
        body="Malignance Tabard",
        legs="Malignance Tights", 
        feet="Malignance Boots"
    })

    -- 30% Haste 1626 / 798
    sets.engaged.Haste_30 = set_combine(sets.engaged.Haste_35, {
        ear1="Telos Earring",
        body="Adhemar Jacket +1",
    })
    sets.engaged.Mid.Haste_30 = set_combine(sets.engaged.Mid.Haste_35, {
        ear2="Suppanomimi",
        waist="Shetal Stone",
        --legs=HercLegs.TP
    })
    sets.engaged.Acc.Haste_30 = set_combine(sets.engaged.Acc.Haste_35, {
        head="Malignance Chapeau",
        ear2="Suppanomimi",
        ring1="Cacoethic Ring +1",
        legs="Malignance Tights", 
    })
     sets.engaged.Learning.Haste_30 = set_combine(sets.engaged.Haste_30, sets.Learning)

    sets.engaged.PDT.Haste_30 = set_combine(sets.engaged.Haste_30, {
        ammo="Crepuscular Pebble",
        ring1="Defending Ring",
        head="Nyame Helm",
        body="Nyame Mail",
        hands="Nyame Gauntlets",
        legs="Nyame Flanchard",
        feet="Nyame Sollerets",
    })
    sets.engaged.Mid.PDT.Haste_30 = set_combine(sets.engaged.Mid.Haste_30, {
        ammo="Crepuscular Pebble",
        ring1="Defending Ring",
        head="Nyame Helm",
        body="Nyame Mail",
        hands="Nyame Gauntlets",
        legs="Nyame Flanchard",
        feet="Nyame Sollerets",
    })
    sets.engaged.Acc.PDT.Haste_30 = set_combine(sets.engaged.Acc.Haste_30, {
        ammo="Crepuscular Pebble",
        ring1="Defending Ring",
        head="Nyame Helm",
        body="Nyame Mail",
        hands="Nyame Gauntlets",
        legs="Nyame Flanchard",
        feet="Nyame Sollerets",
    })
    sets.engaged.EVA.Haste_30 = set_combine(sets.engaged.Haste_30, {
        ammo="Crepuscular Pebble",
        head="Malignance Chapeau",
        ring1="Defending Ring",
        body="Malignance Tabard",
        legs="Malignance Tights", 
        hands="Malignance Gloves",
        feet="Malignance Boots"
    })
    sets.engaged.Mid.EVA.Haste_30 = set_combine(sets.engaged.Mid.Haste_30, {
        ammo="Crepuscular Pebble",
        head="Malignance Chapeau",
        ring1="Defending Ring",
        body="Malignance Tabard",
        legs="Malignance Tights", 
        hands="Malignance Gloves",
        feet="Malignance Boots"
    })
    sets.engaged.Acc.EVA.Haste_30 = set_combine(sets.engaged.Acc.Haste_30, {
        ammo="Crepuscular Pebble",
        head="Malignance Chapeau",
        ring1="Defending Ring",
        body="Malignance Tabard",
        legs="Malignance Tights", 
        hands="Malignance Gloves",
        feet="Malignance Boots"
    })


    -- haste spell - 139 dex | 275 acc | 1150 total acc (with shigi R15)
    sets.engaged.Haste_15 = set_combine(sets.engaged, {
        ear1="Telos Earring"
    })
    sets.engaged.Mid.Haste_15 = sets.engaged.Acc.Haste_30
    sets.engaged.Acc.Haste_15 = sets.engaged.Acc.Haste_30
    
    sets.engaged.PDT.Haste_15 = set_combine(sets.engaged.Haste_15, {
        neck="Twilight Torque",
        ring1="Defending Ring",
        ring2="Patricius Ring",
        head="Nyame Helm",
        body="Nyame Mail",
        hands="Nyame Gauntlets",
        legs="Nyame Flanchard",
        feet="Nyame Sollerets",
    })
    sets.engaged.Mid.PDT.Haste_15 = set_combine(sets.engaged.Mid.Haste_15, {
        neck="Twilight Torque",
        ring1="Defending Ring",
        ring2="Patricius Ring",
        head="Nyame Helm",
        body="Nyame Mail",
        hands="Nyame Gauntlets",
        legs="Nyame Flanchard",
        feet="Nyame Sollerets",
    })
    sets.engaged.Acc.PDT.Haste_15 = set_combine(sets.engaged.Acc.Haste_15, {
        neck="Twilight Torque",
        ring1="Defending Ring",
        ring2="Patricius Ring",
        head="Nyame Helm",
        body="Nyame Mail",
        hands="Nyame Gauntlets",
        legs="Nyame Flanchard",
        feet="Nyame Sollerets",
    })
    sets.engaged.EVA.Haste_15 = set_combine(sets.engaged.Haste_15, {
        head="Malignance Chapeau",
        neck="Twilight Torque",
        ring1="Defending Ring",
        ring2="Patricius Ring",
        body="Malignance Tabard",
        legs="Malignance Tights", 
    })
    sets.engaged.Mid.EVA.Haste_15 = set_combine(sets.engaged.Mid.Haste_15, {
        head="Malignance Chapeau",
        neck="Twilight Torque",
        ring1="Defending Ring",
        ring2="Patricius Ring",
        body="Malignance Tabard",
        legs="Malignance Tights", 
    })
    sets.engaged.Acc.EVA.Haste_15 = set_combine(sets.engaged.Acc.Haste_15, {
        head="Malignance Chapeau",
        neck="Twilight Torque",
        ring1="Defending Ring",
        ring2="Patricius Ring",
        body="Malignance Tabard",
        legs="Malignance Tights", 
    })

    --sets.self_healing = {ring1="Kunaji Ring",ring2="Asklepian Ring"}
end

-------------------------------------------------------------------------------------------------------------------
-- Job-specific hooks for standard casting events.
-------------------------------------------------------------------------------------------------------------------

-- Set eventArgs.handled to true if we don't want any automatic gear equipping to be done.
-- Set eventArgs.useMidcastGear to true if we want midcast gear equipped on precast.
function job_precast(spell, action, spellMap, eventArgs)
    if unbridled_spells:contains(spell.english) and not state.Buff['Unbridled Learning'] then
        eventArgs.cancel = true
        windower.send_command('@input /ja "Unbridled Learning" <me>; wait 1.5; input /ma "'..spell.name..'" '..spell.target.name)
    end
    if spell.name == 'Spectral Jig' and buffactive.sneak then
        -- If sneak is active when using, cancel before completion
        send_command('cancel 71')
    end
    if string.find(spell.english, 'Utsusemi') then
        if buffactive['Copy Image (3)'] or buffactive['Copy Image (4)'] then
            cancel_spell()
            eventArgs.cancel = true
            return
        end
    end

end

-- Run after the default midcast() is done.
-- eventArgs is the same one used in job_midcast, in case information needs to be persisted.
function job_post_midcast(spell, action, spellMap, eventArgs)
    -- Add enhancement gear for Chain Affinity, etc.
    if spell.skill == 'Blue Magic' then
        for buff,active in pairs(state.Buff) do
            if active and sets.buff[buff] then
                equip(sets.buff[buff])
            end
        end
        if spellMap == 'Healing' and spell.target.type == 'SELF' and sets.self_healing then
            equip(sets.self_healing)
        end
    end

    -- If in learning mode, keep on gear intended to help with that, regardless of action.
    if state.OffenseMode.value == 'Learning' then
        equip(sets.Learning)
    end
end

function job_aftercast(spell, action, spellMap, eventArgs)
    if spell.name == 'Pollen' and state.SkillMode.value == 'On' then
        windower.send_command('wait 3; input /ma "'..spell.name..'" '..spell.target.name)
    end
end
-------------------------------------------------------------------------------------------------------------------
-- Job-specific hooks for non-casting events.
-------------------------------------------------------------------------------------------------------------------

-- Called when a player gains or loses a buff.
-- buff == buff gained or lost
-- gain == true if the buff was gained, false if it was lost.
function job_buff_change(buff, gain)
    if state.Buff[buff] ~= nil then
        state.Buff[buff] = gain
    end
    -- If we gain or lose any haste buffs, adjust which gear set we target.
    if S{'haste', 'march', 'mighty guard', 'embrava', 'haste samba', 'geo-haste', 'indi-haste'}:contains(buff:lower()) then
        determine_haste_group()
        if not midaction() then
            handle_equipping_gear(player.status)
        end
    end
    if buff:startswith('Aftermath') then
        if player.equipment.main == 'Tizona' then
            classes.CustomMeleeGroups:clear()

            if (buff == "Aftermath: Lv.3" and gain) or buffactive['Aftermath: Lv.3'] then
                classes.CustomMeleeGroups:append('AM3')
                add_to_chat(8, '-------------AM3 UP-------------')
            end

            if not midaction() then
                handle_equipping_gear(player.status)
            end
        end
    end

end

-------------------------------------------------------------------------------------------------------------------
-- User code that supplements standard library decisions.
-------------------------------------------------------------------------------------------------------------------

-- Custom spell mapping.
-- Return custom spellMap value that can override the default spell mapping.
-- Don't return anything to allow default spell mapping to be used.
function job_get_spell_map(spell, default_spell_map)
    if spell.skill == 'Blue Magic' then
        for category,spell_list in pairs(blue_magic_maps) do
            if spell_list:contains(spell.english) then
                return category
            end
        end
    end
end

-- Modify the default idle set after it was constructed.
function customize_idle_set(idleSet)
    if player.mpp < 51 then
        set_combine(idleSet, sets.latent_refresh)
    end
    return idleSet
end

-- Called by the 'update' self-command, for common needs.
-- Set eventArgs.handled to true if we don't want automatic equipping of gear.
function job_update(cmdParams, eventArgs)
    update_combat_form()
    determine_haste_group()
    th_update(cmdParams, eventArgs)
end

function check_buff(buff_name, eventArgs)
    if state.Buff[buff_name] then
        equip(sets.buff[buff_name] or {})
        if state.TreasureMode.value == 'SATA' or state.TreasureMode.value == 'Fulltime' then
            equip(sets.TreasureHunter)
        end
        eventArgs.handled = true
    end
end
-- Check for various actions that we've specified in user code as being used with TH gear.
-- This will only ever be called if TreasureMode is not 'None'.
-- Category and Param are as specified in the action event packet.
function th_action_check(category, param)
    if category == 2 or -- any ranged attack
        --category == 4 or -- any magic action
        (category == 3 and param == 30) or -- Aeolian Edge
        (category == 6 and info.default_ja_ids:contains(param)) or -- Provoke, Animated Flourish
        (category == 14 and info.default_u_ja_ids:contains(param)) -- Quick/Box/Stutter Step, Desperate/Violent Flourish
        then 
            return true
    end
end

function determine_haste_group()

    classes.CustomMeleeGroups:clear()
    -- mythic AM	
    if player.equipment.main == 'Tizona' then
        if buffactive['Aftermath: Lv.3'] then
            classes.CustomMeleeGroups:append('AM3')
        end
    end
    -- assuming +4 for marches (ghorn has +5)
    -- Haste (white magic) 15%
    -- Haste Samba (Sub) 5%
    -- Haste (Merited DNC) 10% (never account for this)
    -- Victory March +0/+3/+4/+5    9.4/14%/15.6%/17.1% +0
    -- Advancing March +0/+3/+4/+5  6.3/10.9%/12.5%/14%  +0
    -- Embrava 30% with 500 enhancing skill
    -- Mighty Guard - 15%
    -- buffactive[580] = geo haste
    -- buffactive[33] = regular haste
    -- buffactive[604] = mighty guard
    -- state.HasteMode = toggle for when you know Haste II is being cast on you
    -- Hi = Haste II is being cast. This is clunky to use when both haste II and haste I are being cast
    if ( ( (buffactive[33] or buffactive[580] or buffactive.embrava) and (buffactive.march or buffactive[604]) ) or
            ( buffactive[33] and (buffactive[580] or buffactive.embrava) ) or
            ( buffactive.march == 2 and buffactive[604] ) ) then
        add_to_chat(8, '-------------Max-Haste Mode Enabled--------------')
        classes.CustomMeleeGroups:append('MaxHaste')
    elseif ( (buffactive[33] or buffactive.march == 2 or buffactive[580]) and buffactive['haste samba'] ) then
        add_to_chat(8, '-------------Haste 35%-------------')
        classes.CustomMeleeGroups:append('Haste_35')
    elseif ( ( buffactive[580] or buffactive[33] or buffactive.march == 2 ) or
                ( buffactive.march == 1 and buffactive[604] ) ) then
        add_to_chat(8, '-------------Haste 30%-------------')
        classes.CustomMeleeGroups:append('Haste_30')
    elseif ( buffactive.march == 1 or buffactive[604] ) then
        add_to_chat(8, '-------------Haste 15%-------------')
        classes.CustomMeleeGroups:append('Haste_15')
    end

end

-------------------------------------------------------------------------------------------------------------------
-- Utility functions specific to this job.
-------------------------------------------------------------------------------------------------------------------

function update_combat_form()
    -- Check for H2H or single-wielding
    --if player.equipment.sub == "Genbu's Shield" or player.equipment.sub == 'empty' then
    --    state.CombatForm:reset()
    --end
end


-- Select default macro book on initial load or subjob change.
function select_default_macro_book()
    -- Default macro set/book
    if player.sub_job == 'DNC' then
        set_macro_page(2, 7)
    else
        set_macro_page(1, 7)
    end
end



