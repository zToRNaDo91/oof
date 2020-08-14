Blip = class()

BlipPositionType = 
{
    Coord = 1,
    Entity = 2,
    Radius = 3
}

--[[
    Creates a blip.

    args (in table):
        type (blip hash): hash of the type of the blip
        position_type (BlipPositionType): type of positioning this blip uses
        
            If BlipPositionType.Coord:
                position (vector3): position of the blip
            If BlipPositionType.Entity:
                entity (Entity): entity that the blip is attached to
            If BlipPositionType.Radius:
                position (vector3): position of the blip
                radius (number): radius at which the blip appears

]]
function Blip:__init(args)

    if args.position_type == BlipPositionType.Coord then
        self.blip_id = Citizen.InvokeNative(0x554D9D53F696D002, args.type, args.position.x, args.position.y, args.position.z)
    elseif args.position_type == BlipPositionType.Entity then
        self.blip_id = BlipAddForEntity(args.type, args.entity)
    elseif args.position_type == BlipPositionType.Radius then
        self.blip_id = BlipAddForRadius(args.type, args.position.x, args.position.y, args.position.z, args.radius)
    end

end

-- Sets a modifier on the blip. Use BlipModifier
function Blip:SetModifier(modifier)
    Citizen.InvokeNative(0x662D364ABF16DE2F, self.blip_id, modifier)
end

function Blip:SetName(name)
    Citizen.InvokeNative(0x0A062D6D7C0B2C2C, self.blip_id, tostring(name))
end

function Blip:SetPosition(pos)
    Citizen.InvokeNative(0x4FF674F5E23D49CE, self.blip_id, pos.x, pos.y, pos.z)
end

function Blip:SetScale(scale)
    Citizen.InvokeNative(0xD38744167B2FA257, self.blip_id, tofloat(scale))
end

function Blip:Remove()
    Citizen.InvokeNative(0xF2C3C9DA47AAA54A, self.blip_id)
end

-- From GlitchDetector
local BLIP_TYPES = {
    -678244495, -- gray destination
    -1702907713, -- pink enemy
    -1337945352, -- white unselectable?
    1560611276, -- posse camp
    -674883803, -- invisible?
    1687768444, -- destination, mine icon?
    1260140857, -- invisible?
    -1230993421, -- horse icon "Arthur's Horse"
    -936216634, -- white unselectable?
    2098831270, -- white no name?
    -325639900, -- white pickup
    -773443467, -- corpse
    -700928964, -- gray herd
    -214162151, -- yellow straggler
    -1594303955, -- animal carcass
    662885764, -- red lawman
    -1049390151, -- red witness
    953018525, -- red bounty target
    455691738, -- red bounty target
    -839369609, -- red enemy
    -1749618580, -- white companion
    168093330, -- white destination
    -1595050198, -- red lawman
    -118010418, -- red alternative? lawman
    522464759, -- red bounty hunter
    631964804, -- wagon icon "Arthur's Wagon"
    1055493006, -- small yellow (x) destination
    486881925, -- white hat
    203020899, -- small yellow (x) destination
    -399496385, -- train
    -89429847, -- light gray companion
    1664425300, -- white weapon
    831283580, -- red enemy
    422991367, -- dark gray companion
    -515518185, -- white saddle unselectable?
    2033377404, -- yellow ( ) unselectable?
    -308585968, -- yellow (x) destination
    -108658760, -- invisible?
    -666422021, -- red ( ) unselectable?
    1774867085, -- invisible?
    -1282792512, -- yellow ( ) unselectable?
    227551412, -- yellow ( ) unselectable?
    408396114, -- yellow (x) destination
    -1559907306, -- white ( ) unselectable?
    1673015813, -- white ( ) unselectable?
    1247852480, -- yellow ( ) unselectable?
}

-- From https://alloc8or.re/rdr3/doc/enums/eBlipModifier.txt
BlipModifier =
{
	BLIP_MODIFIER_ANIMAL_SKINNED = 0xFCAD9589,
	BLIP_MODIFIER_AREA = 0xA2814CC7,
	BLIP_MODIFIER_AREA_ACCURATE = 0x1B0442BC,
	BLIP_MODIFIER_AREA_CLAMPED_PULSE = 0xA0A765A1,
	BLIP_MODIFIER_AREA_CONTESTED = 0x6E1AE519,
	BLIP_MODIFIER_AREA_DIRECTIONAL = 0x38E24039,
	BLIP_MODIFIER_AREA_HIDE_ON_INSIDE = 0xAD9CBA59,
	BLIP_MODIFIER_AREA_HIDE_ON_OUTSIDE = 0xD4BC0DD7,
	BLIP_MODIFIER_AREA_NO_BLIP = 0x209E2223,
	BLIP_MODIFIER_AREA_OUT_OF_BOUNDS = 0xAB81D4D6,
	BLIP_MODIFIER_AREA_PULSE = 0x1BE311B3,
	BLIP_MODIFIER_AREA_TAKEOVER = 0x3494D1C8,
	BLIP_MODIFIER_ATTENTION = 0x0240DE18,
	BLIP_MODIFIER_BOUNTY_TARGET_INCAPACITATED = 0xF51B7DD8,
	BLIP_MODIFIER_CAMP_NOT_READY = 0xE852BB00,
	BLIP_MODIFIER_CHASE = 0x65D2880A,
	BLIP_MODIFIER_COLLECTIBLE_FULL = 0x7BE2D07B,
	BLIP_MODIFIER_COMPANION_ACTIVITY = 0x56B8B889,
	BLIP_MODIFIER_COMPANION_CONVERSATION = 0xB4CA5F4C,
	BLIP_MODIFIER_COMPANION_DOG = 0x0B93E613,
	BLIP_MODIFIER_COMPANION_OBJECTIVE = 0xDF69E371,
	BLIP_MODIFIER_COMPANION_WOUNDED = 0x18006B2F,
	BLIP_MODIFIER_COMPASS_OBJECTIVE = 0x0DC7BE1A,
	BLIP_MODIFIER_CREATOR_FOCUS = 0x557F109C,
	BLIP_MODIFIER_CULL_ON_DEATH = 0xAA235D8B,
	BLIP_MODIFIER_DEBUG_BLUE = 0xF91DD38D,
	BLIP_MODIFIER_DEBUG_GREEN = 0xA2329CFC,
	BLIP_MODIFIER_DEBUG_MP_PLAYER_RANGE_50 = 0x3641DFFD,
	BLIP_MODIFIER_DEBUG_MP_PLAYER_RANGE_60 = 0x79D04EFD,
	BLIP_MODIFIER_DEBUG_MP_PLAYER_RANGE_70 = 0x24B825F6,
	BLIP_MODIFIER_DEBUG_MP_PLAYER_RANGE_80 = 0xC4D902E9,
	BLIP_MODIFIER_DEBUG_MP_PLAYER_RANGE_90 = 0x89D18B7B,
	BLIP_MODIFIER_DEBUG_MP_PLAYER_RANGE_100 = 0x6E4A4129,
	BLIP_MODIFIER_DEBUG_MP_PLAYER_RANGE_110 = 0x42F16BDC,
	BLIP_MODIFIER_DEBUG_MP_PLAYER_RANGE_120 = 0x5ECE0101,
	BLIP_MODIFIER_DEBUG_MP_PLAYER_RANGE_130 = 0x8A085851,
	BLIP_MODIFIER_DEBUG_MP_PLAYER_RANGE_140 = 0x93A36BEF,
	BLIP_MODIFIER_DEBUG_MP_PLAYER_RANGE_150 = 0x92FCEB86,
	BLIP_MODIFIER_DEBUG_PINK = 0xF89D75CE,
	BLIP_MODIFIER_DEBUG_RED = 0x3F90ADF0,
	BLIP_MODIFIER_DEBUG_YELLOW = 0xA5C4F725,
	BLIP_MODIFIER_DIRECTION_ONLY = 0x5824DF7B,
	BLIP_MODIFIER_DISTANCE_FADE_LONG = 0x8F934A09,
	BLIP_MODIFIER_DISTANCE_FADE_MEDIUM = 0x23BCF4A2,
	BLIP_MODIFIER_DISTANCE_FADE_SHORT = 0x111DDB96,
	BLIP_MODIFIER_EAGLE_EYE = 0x61D6FB44,
	BLIP_MODIFIER_ENEMY = 0x382616F3,
	BLIP_MODIFIER_ENEMY_AQUATIC = 0x4BCEFC2C,
	BLIP_MODIFIER_ENEMY_CONFRONTING = 0x2CB39D87,
	BLIP_MODIFIER_ENEMY_DISAPPEARING = 0x7CFAB4C0,
	BLIP_MODIFIER_ENEMY_DISAPPEARING_NO_FLEE_CHECKS = 0x0FCDCDBA,
	BLIP_MODIFIER_ENEMY_DISAPPEARING_NO_SCREEN_CHECKS = 0x01852773,
	BLIP_MODIFIER_ENEMY_FLEEING = 0x1FDAEC84,
	BLIP_MODIFIER_ENEMY_GUNSHOTS_FADE_ON_START = 0x57F061DF,
	BLIP_MODIFIER_ENEMY_GUNSHOTS_ONLY = 0xC256FEAF,
	BLIP_MODIFIER_ENEMY_GUNSHOTS_ONLY_DONT_SHOW_LAST = 0x27CCDA52,
	BLIP_MODIFIER_ENEMY_IMPORTANT = 0xC77D831F,
	BLIP_MODIFIER_ENEMY_IS_ALERTED = 0xF85DCD5A,
	BLIP_MODIFIER_ENEMY_LOWER_AWARENESS = 0x50235612,
	BLIP_MODIFIER_ENEMY_MUST_AGGRO = 0x69392A93,
	BLIP_MODIFIER_ENEMY_OBJECTIVE = 0x76F4E8FE,
	BLIP_MODIFIER_ENEMY_ON_GUARD = 0xD886D9BD,
	BLIP_MODIFIER_ENEMY_ON_GUARD_DISAPPEARING = 0x5C6421C6,
	BLIP_MODIFIER_ENEMY_ON_GUARD_NO_CONE = 0x6CA7BBEA,
	BLIP_MODIFIER_ENEMY_STEALTH_KILL = 0xBD592C8A,
	BLIP_MODIFIER_ENEMY_TARGETED_ONLY = 0xE9CA636F,
	BLIP_MODIFIER_FADE = 0x0BC9C3EA,
	BLIP_MODIFIER_FADE_IN = 0x92B0B70B,
	BLIP_MODIFIER_FADE_OUT_AND_DIE = 0xB452F7BC,
	BLIP_MODIFIER_FADE_OUT_SLOW = 0x5426DAB6,
	BLIP_MODIFIER_FETCH_ESCAPING = 0xE6239722,
	BLIP_MODIFIER_FETCH_VIP = 0xEA14463A,
	BLIP_MODIFIER_FISHING_SPOT_LEGENDARY = 0xECF9168E,
	BLIP_MODIFIER_FISHING_SPOT_NORMAL = 0xEA65CDBA,
	BLIP_MODIFIER_FLASH_FOREVER = 0xC1DBF36F,
	BLIP_MODIFIER_FLASH_LONG = 0xEE89BCA4,
	BLIP_MODIFIER_FLASH_MEDIUM = 0xAB58E957,
	BLIP_MODIFIER_FLASH_SHORT = 0xFD78CEA0,
	BLIP_MODIFIER_FORCE_GPS = 0x900A4D0A,
	BLIP_MODIFIER_FORCE_GPS_HORSE_ONLY = 0x3138895A,
	BLIP_MODIFIER_FOR_SALE = 0xDAA61911,
	BLIP_MODIFIER_FRIENDLY = 0x6414AA9A,
	BLIP_MODIFIER_FRIENDLY_OBJECTIVE = 0xC586CF7A,
	BLIP_MODIFIER_GROUPING_ANNESBURG_FOLLOWER = 0x2AE46EBC,
	BLIP_MODIFIER_GROUPING_ANNESBURG_LEADER = 0x40E25DCA,
	BLIP_MODIFIER_GROUPING_ARMADILLO_FOLLOWER = 0x8E27BEE2,
	BLIP_MODIFIER_GROUPING_ARMADILLO_LEADER = 0xE78838E6,
	BLIP_MODIFIER_GROUPING_BLACKWATER_FOLLOWER = 0x18E342E4,
	BLIP_MODIFIER_GROUPING_BLACKWATER_LEADER = 0xE7680160,
	BLIP_MODIFIER_GROUPING_CAMP_GROUP_FOLLOWER = 0xC2DA72DF,
	BLIP_MODIFIER_GROUPING_CAMP_GROUP_LEADER = 0x006D127B,
	BLIP_MODIFIER_GROUPING_EMERALD_RANCH_FOLLOWER = 0xF9019D82,
	BLIP_MODIFIER_GROUPING_EMERALD_RANCH_LEADER = 0xD90EE444,
	BLIP_MODIFIER_GROUPING_LAGRAS_FOLLOWER = 0xF66BD5ED,
	BLIP_MODIFIER_GROUPING_LAGRAS_LEADER = 0x4FFB50CE,
	BLIP_MODIFIER_GROUPING_RHODES_FOLLOWER = 0x5FD46EFD,
	BLIP_MODIFIER_GROUPING_RHODES_LEADER = 0x6A8F7D89,
	BLIP_MODIFIER_GROUPING_SAINT_DENIS_FOLLOWER = 0xD4B0DE9F,
	BLIP_MODIFIER_GROUPING_SAINT_DENIS_LEADER = 0x9A4A35F1,
	BLIP_MODIFIER_GROUPING_STRAWBERRY_FOLLOWER = 0xFD0B94FF,
	BLIP_MODIFIER_GROUPING_STRAWBERRY_LEADER = 0x10AF1468,
	BLIP_MODIFIER_GROUPING_THIEVES_LANDING_FOLLOWER = 0x0D2C9B03,
	BLIP_MODIFIER_GROUPING_THIEVES_LANDING_LEADER = 0x8C0FCC22,
	BLIP_MODIFIER_GROUPING_TUMBLEWEED_FOLLOWER = 0xF6625BEA,
	BLIP_MODIFIER_GROUPING_TUMBLEWEED_LEADER = 0x617B3C27,
	BLIP_MODIFIER_GROUPING_VALENTINE_FOLLOWER = 0xEAB8759D,
	BLIP_MODIFIER_GROUPING_VALENTINE_LEADER = 0x69F71E2A,
	BLIP_MODIFIER_GROUPING_VAN_HORN_FOLLOWER = 0x56FFFA4D,
	BLIP_MODIFIER_GROUPING_VAN_HORN_LEADER = 0x1893878C,
	BLIP_MODIFIER_HERB_NORMAL = 0x111C4609,
	BLIP_MODIFIER_HERB_SHORT_RANGE = 0xE5EABD23,
	BLIP_MODIFIER_HERB_SURVIVALIST = 0xC841BF7B,
	BLIP_MODIFIER_HIDDEN = 0xB946AEF0,
	BLIP_MODIFIER_HIDEOUT_ABANDONED = 0x9916A554,
	BLIP_MODIFIER_HIDE_HEIGHT_MARKER = 0x12A92549,
	BLIP_MODIFIER_HIGH_CATEGORY = 0xCCC27837,
	BLIP_MODIFIER_HORSE_REVIVE = 0x19A98226,
	BLIP_MODIFIER_HORSE_REVIVE_2 = 0xC4ADB894,
	BLIP_MODIFIER_HORSE_REVIVE_3 = 0xFE81AC3F,
	BLIP_MODIFIER_HORSE_REVIVE_4 = 0xF03A0FB0,
	BLIP_MODIFIER_HORSE_STOLEN = 0xADB5B7AC,
	BLIP_MODIFIER_HOSTILITY_COLOR_1 = 0xE879F8B1,
	BLIP_MODIFIER_HOSTILITY_COLOR_2 = 0x79BB9B36,
	BLIP_MODIFIER_HOSTILITY_COLOR_3 = 0x5E646480,
	BLIP_MODIFIER_HOSTILITY_VISIBILITY_1 = 0x3D4C6EA4,
	BLIP_MODIFIER_HOSTILITY_VISIBILITY_2 = 0x2A6EC8E9,
	BLIP_MODIFIER_HOSTILITY_VISIBILITY_3 = 0xD833246F,
	BLIP_MODIFIER_HOSTILITY_VISIBILITY_4 = 0x05D27FAD,
	BLIP_MODIFIER_JOB = 0x845A1E41,
	BLIP_MODIFIER_JOB_BILL = 0x5A9CF68D,
	BLIP_MODIFIER_JOB_CHARLES = 0x382968CB,
	BLIP_MODIFIER_JOB_HOSEA = 0x024D547E,
	BLIP_MODIFIER_JOB_JAVIER = 0xA66B982F,
	BLIP_MODIFIER_JOB_JOHN = 0x7EA2F90A,
	BLIP_MODIFIER_JOB_KAREN = 0x955011CB,
	BLIP_MODIFIER_JOB_KIERAN = 0x78BE3FBC,
	BLIP_MODIFIER_JOB_LENNY = 0x81F28880,
	BLIP_MODIFIER_JOB_LOANSHARK = 0x1D8CAE74,
	BLIP_MODIFIER_JOB_MICAH = 0xA26E278F,
	BLIP_MODIFIER_JOB_PEARSON = 0xC5B01DDB,
	BLIP_MODIFIER_JOB_SEAN = 0x31FDE57D,
	BLIP_MODIFIER_JOB_STRAUSS = 0x4FEF10D0,
	BLIP_MODIFIER_JOB_TILLY = 0xCAA7A516,
	BLIP_MODIFIER_JOB_UNCLE = 0x0AAD9F18,
	BLIP_MODIFIER_KEY_JOB = 0x27045619,
	BLIP_MODIFIER_KEY_MISSION = 0x899B9B5B,
	BLIP_MODIFIER_KEY_MISSION_OBJECT = 0x1AACFBAC,
	BLIP_MODIFIER_LAW_ORDER = 0x96AEC03E,
	BLIP_MODIFIER_LEGENDARY = 0xE07A6699,
	BLIP_MODIFIER_LOCAL_PLAYER_FOLLOWING_OBJECTIVE = 0x61402938,
	BLIP_MODIFIER_LOCAL_PLAYER_HOSTILITY_HIGH = 0xDC3AF7F5,
	BLIP_MODIFIER_LOCAL_PLAYER_HOSTILITY_MEDIUM = 0xD5E10172,
	BLIP_MODIFIER_LOCAL_PLAYER_MADE_VISIBLE = 0xB84A87B1,
	BLIP_MODIFIER_LOCAL_PLAYER_OWNED = 0xB3892473,
	BLIP_MODIFIER_LOCKED = 0x2B30E11F,
	BLIP_MODIFIER_LOOTED = 0x3BD5E2A6,
	BLIP_MODIFIER_LOS_DISAPPEARING = 0x1C65CE16,
	BLIP_MODIFIER_MC_STEALTH_LENIENT = 0xABB7E963,
	BLIP_MODIFIER_MC_STEALTH_MEDIUM = 0x989ED60F,
	BLIP_MODIFIER_MC_STEALTH_STRICT = 0x53A68A36,
	BLIP_MODIFIER_MC_STEALTH_VERY_LENIENT = 0xFBCE3A88,
	BLIP_MODIFIER_MC_STEALTH_VERY_STRICT = 0xE0485D1B,
	BLIP_MODIFIER_MISSION_UNAVAILABLE = 0x821511C0,
	BLIP_MODIFIER_MP_COLOR_1 = 0x1DD3A06B,
	BLIP_MODIFIER_MP_COLOR_2 = 0x6F85C3CE,
	BLIP_MODIFIER_MP_COLOR_3 = 0x8D2FFF22,
	BLIP_MODIFIER_MP_COLOR_4 = 0xECA93E13,
	BLIP_MODIFIER_MP_COLOR_5 = 0x3A585978,
	BLIP_MODIFIER_MP_COLOR_6 = 0x481674F4,
	BLIP_MODIFIER_MP_COLOR_7 = 0x15BD9043,
	BLIP_MODIFIER_MP_COLOR_8 = 0xA1B5A82D,
	BLIP_MODIFIER_MP_COLOR_9 = 0xF376CBAE,
	BLIP_MODIFIER_MP_COLOR_10 = 0x6A44C8F2,
	BLIP_MODIFIER_MP_COLOR_11 = 0xA6964198,
	BLIP_MODIFIER_MP_COLOR_12 = 0x57E2242D,
	BLIP_MODIFIER_MP_COLOR_13 = 0x8A3D88E7,
	BLIP_MODIFIER_MP_COLOR_14 = 0xB77BE363,
	BLIP_MODIFIER_MP_COLOR_15 = 0xEF61D32E,
	BLIP_MODIFIER_MP_COLOR_16 = 0xA1A7B7BB,
	BLIP_MODIFIER_MP_COLOR_17 = 0xD2CF1A09,
	BLIP_MODIFIER_MP_COLOR_18 = 0x0518FE9C,
	BLIP_MODIFIER_MP_COLOR_19 = 0x38AB65C4,
	BLIP_MODIFIER_MP_COLOR_20 = 0x121C9983,
	BLIP_MODIFIER_MP_COLOR_21 = 0x7D55EFF4,
	BLIP_MODIFIER_MP_COLOR_22 = 0x6700C34A,
	BLIP_MODIFIER_MP_COLOR_23 = 0x8EA29299,
	BLIP_MODIFIER_MP_COLOR_24 = 0xA3F7BD43,
	BLIP_MODIFIER_MP_COLOR_25 = 0xF351DBF6,
	BLIP_MODIFIER_MP_COLOR_26 = 0xF85BE60A,
	BLIP_MODIFIER_MP_COLOR_27 = 0xCCED8F2E,
	BLIP_MODIFIER_MP_COLOR_28 = 0xDB4D2BED,
	BLIP_MODIFIER_MP_COLOR_29 = 0x29894868,
	BLIP_MODIFIER_MP_COLOR_30 = 0xE643BEC2,
	BLIP_MODIFIER_MP_COLOR_31 = 0xFEDE6FF7,
	BLIP_MODIFIER_MP_COLOR_32 = 0xEF1F5079,
	BLIP_MODIFIER_MP_DEADEYE = 0xA202CD8F,
	BLIP_MODIFIER_MP_DOWNED = 0x24CB3FB5,
	BLIP_MODIFIER_MP_ENEMY_HOLDING = 0x738B1D05,
	BLIP_MODIFIER_MP_FREE_ROAM_EE_PLAYER_DISAPPEARING = 0xF8D0C5F4,
	BLIP_MODIFIER_MP_FREE_ROAM_MISSION_PLAYER_DISAPPEARING = 0xC502F416,
	BLIP_MODIFIER_MP_FREE_ROAM_PLAYER_DISAPPEARING = 0x570171C0,
	BLIP_MODIFIER_MP_FRIENDLY_HOLDING = 0x22E21DB2,
	BLIP_MODIFIER_MP_HOT_BLIP = 0x2B389337,
	BLIP_MODIFIER_MP_HUNTER = 0x56AA576C,
	BLIP_MODIFIER_MP_JOB_PLAYER_FADE = 0xB87AC128,
	BLIP_MODIFIER_MP_JOB_PLAYER_FADE_THREAT = 0xF4C0F156,
	BLIP_MODIFIER_MP_MARKED_FOR_DEATH = 0x3ABF4B6C,
	BLIP_MODIFIER_MP_NEUTRAL = 0x7C687658,
	BLIP_MODIFIER_MP_OBJECTIVE = 0xE0E7C82B,
	BLIP_MODIFIER_MP_OBJECTIVE_ENEMY = 0x801DD820,
	BLIP_MODIFIER_MP_OBJECTIVE_FRIENDLY = 0xA9DBBFDC,
	BLIP_MODIFIER_MP_OBJECTIVE_NEUTRAL = 0x9E703B63,
	BLIP_MODIFIER_MP_PLAYER = 0x2B24376B,
	BLIP_MODIFIER_MP_PLAYER_AGGRESSION = 0xA81F94DD,
	BLIP_MODIFIER_MP_PLAYER_ALLY = 0xB1AE1182,
	BLIP_MODIFIER_MP_PLAYER_ALLY_WOUNDED = 0xDAC99B52,
	BLIP_MODIFIER_MP_PLAYER_BAG = 0x43192021,
	BLIP_MODIFIER_MP_PLAYER_CONTROL = 0x3A6AF541,
	BLIP_MODIFIER_MP_PLAYER_COOP = 0xA4F9F040,
	BLIP_MODIFIER_MP_PLAYER_DISAPPEARING = 0x40FB8A3E,
	BLIP_MODIFIER_MP_PLAYER_ENEMY = 0xDB76C121,
	BLIP_MODIFIER_MP_PLAYER_FORCE_BLIPPED = 0xBF92F77C,
	BLIP_MODIFIER_MP_PLAYER_KING = 0xF548DEA6,
	BLIP_MODIFIER_MP_PLAYER_LOS_ONLY = 0xFDB13448,
	BLIP_MODIFIER_MP_PLAYER_NEUTRAL = 0x5F947624,
	BLIP_MODIFIER_MP_PLAYER_SOCIAL = 0x874A4100,
	BLIP_MODIFIER_MP_PLAYER_UNAVAILABLE = 0x97A0C01F,
	BLIP_MODIFIER_MP_PLAYER_WINNING = 0xE0F654CC,
	BLIP_MODIFIER_MP_PLAYER_WITH_BOUNTY = 0x2B28A10C,
	BLIP_MODIFIER_MP_REVIVE = 0x9125D4D4,
	BLIP_MODIFIER_MP_RIVAL_RACER = 0x3599864F,
	BLIP_MODIFIER_MP_SUPPLIES_BASE_1 = 0x71FD7786,
	BLIP_MODIFIER_MP_SUPPLIES_BASE_2 = 0x40439413,
	BLIP_MODIFIER_MP_SUPPLIES_BASE_3 = 0x55B6BEF9,
	BLIP_MODIFIER_MP_SUPPLIES_BASE_4 = 0x23F9DB7C,
	BLIP_MODIFIER_MP_SUPPLIES_BASE_5 = 0xA932E5F0,
	BLIP_MODIFIER_MP_SUPPLIES_BASE_6 = 0x776D0265,
	BLIP_MODIFIER_MP_SUPPLIES_BASE_7 = 0x8C5E2C47,
	BLIP_MODIFIER_MP_SUPPLIES_BASE_8 = 0x5AA348D2,
	BLIP_MODIFIER_MP_SUPPLIES_BASE_9 = 0xBC6B8C61,
	BLIP_MODIFIER_MP_SUPPLIES_BASE_10 = 0x21EA2A70,
	BLIP_MODIFIER_MP_SUPPLIES_BASE_11 = 0x14308EFD,
	BLIP_MODIFIER_MP_SUPPLIES_BASE_12 = 0x7E70637B,
	BLIP_MODIFIER_MP_SUPPLIES_BASE_13 = 0x70ADC7F6,
	BLIP_MODIFIER_MP_SUPPLIES_BASE_14 = 0xDCA49FE2,
	BLIP_MODIFIER_MP_SUPPLIES_BASE_15 = 0x44BB7016,
	BLIP_MODIFIER_MP_SUPPLIES_BASE_16 = 0x36F4D489,
	BLIP_MODIFIER_MP_SUPPLIES_OUTLINE_COLOR_1 = 0xCFF4D67D,
	BLIP_MODIFIER_MP_SUPPLIES_OUTLINE_COLOR_2 = 0xDD9E71D0,
	BLIP_MODIFIER_MP_SUPPLIES_OUTLINE_COLOR_3 = 0x73729D76,
	BLIP_MODIFIER_MP_SUPPLIES_OUTLINE_COLOR_4 = 0x80C5381B,
	BLIP_MODIFIER_MP_SUPPLIES_OUTLINE_COLOR_5 = 0x1AD7EC4E,
	BLIP_MODIFIER_MP_SUPPLIES_OUTLINE_COLOR_6 = 0xA90D88BB,
	BLIP_MODIFIER_MP_SUPPLIES_OUTLINE_COLOR_7 = 0xBA422B24,
	BLIP_MODIFIER_MP_SUPPLIES_OUTLINE_COLOR_8 = 0xE0737786,
	BLIP_MODIFIER_MP_SUPPLIES_OUTLINE_COLOR_9 = 0x5DC7F221,
	BLIP_MODIFIER_MP_SUPPLIES_OUTLINE_COLOR_10 = 0xFCFB2403,
	BLIP_MODIFIER_MP_TEAM_COLOR_1 = 0x9B795DF5,
	BLIP_MODIFIER_MP_TEAM_COLOR_2 = 0x04F530F3,
	BLIP_MODIFIER_MP_TEAM_COLOR_3 = 0x232C6D61,
	BLIP_MODIFIER_MP_TEAM_COLOR_4 = 0x6876F7FD,
	BLIP_MODIFIER_MP_TEAM_COLOR_5 = 0xF6B79478,
	BLIP_MODIFIER_MP_TEAM_COLOR_6 = 0xDBC05E8A,
	BLIP_MODIFIER_MP_TEAM_COLOR_7 = 0xEA06FB17,
	BLIP_MODIFIER_MP_TEAM_COLOR_8 = 0xAFF286EF,
	BLIP_MODIFIER_MP_WHITE_FLAG = 0x35333C20,
	BLIP_MODIFIER_NEUTRAL_AREA_ON_SNOW = 0x65EDA8F8,
	BLIP_MODIFIER_NEUTRAL_ON_GUARD = 0x4FCB6ECC,
	BLIP_MODIFIER_OBJECTIVE = 0xE80A86F4,
	BLIP_MODIFIER_OBJECTIVE_GET_CLOSE = 0xDF07320A,
	BLIP_MODIFIER_OBJECTIVE_LOW_CATEGORY = 0x8E61423C,
	BLIP_MODIFIER_OPEN_RACE_CHECKPOINT = 0x7C3E16B5,
	BLIP_MODIFIER_OUTSIDE_TOD = 0xA9C5EBA4,
	BLIP_MODIFIER_OVERLAY_1 = 0xE7DF610D,
	BLIP_MODIFIER_OVERLAY_2 = 0xFD868C57,
	BLIP_MODIFIER_OVERLAY_3 = 0x0BD028EA,
	BLIP_MODIFIER_OVERLAY_4 = 0xA30F576E,
	BLIP_MODIFIER_OVERLAY_5 = 0xB151F3F3,
	BLIP_MODIFIER_OVERLAY_6 = 0xC6591E01,
	BLIP_MODIFIER_OVERLAY_RING_MP_COLOR_1 = 0xD9349943,
	BLIP_MODIFIER_OVERLAY_RING_MP_COLOR_2 = 0x71284930,
	BLIP_MODIFIER_OVERLAY_RING_MP_COLOR_3 = 0x5FBB2656,
	BLIP_MODIFIER_OVERLAY_RING_MP_COLOR_4 = 0x2662339D,
	BLIP_MODIFIER_OVERLAY_RING_MP_COLOR_5 = 0x8434EF49,
	BLIP_MODIFIER_OVERLAY_RING_MP_COLOR_6 = 0x4FA0861D,
	BLIP_MODIFIER_OVERLAY_RING_MP_COLOR_7 = 0xBE67E3AA,
	BLIP_MODIFIER_OVERLAY_RING_MP_COLOR_8 = 0x74354F46,
	BLIP_MODIFIER_OVERLAY_RING_MP_COLOR_9 = 0x60E428A4,
	BLIP_MODIFIER_OVERLAY_RING_MP_COLOR_10 = 0x9EB41558,
	BLIP_MODIFIER_OVERLAY_SADDLE = 0x282BAA30,
	BLIP_MODIFIER_OVERLAY_SADDLE_STOLEN = 0x96C146D5,
	BLIP_MODIFIER_OVERLAY_WHITE_1 = 0x508D5857,
	BLIP_MODIFIER_OVERLAY_WHITE_2 = 0x7B482DD0,
	BLIP_MODIFIER_OVERLAY_WHITE_3 = 0xDD10F160,
	BLIP_MODIFIER_OVERLAY_WHITE_4 = 0x99B56AAA,
	BLIP_MODIFIER_OVERLAY_WHITE_5 = 0x8BC4CEC9,
	BLIP_MODIFIER_OVERLAY_WHITE_6 = 0xB17D9A3A,
	BLIP_MODIFIER_OVERLAY_WHITE_7 = 0x2385FE3D,
	BLIP_MODIFIER_OVERLAY_WHITE_8 = 0xCDF15321,
	BLIP_MODIFIER_OVERLAY_WHITE_9 = 0xC039B7B2,
	BLIP_MODIFIER_OVERLAY_WHITE_10 = 0xAC152694,
	BLIP_MODIFIER_OVERLAY_WHITE_11 = 0x9B50850B,
	BLIP_MODIFIER_OVERLAY_WHITE_12 = 0x88F3E05E,
	BLIP_MODIFIER_OVERLAY_WHITE_13 = 0x7FBACDEC,
	BLIP_MODIFIER_OVERLAY_WHITE_14 = 0x6D712959,
	BLIP_MODIFIER_OVERLAY_WHITE_15 = 0x67AE9DD4,
	BLIP_MODIFIER_OVERLAY_WHITE_16 = 0x556CF951,
	BLIP_MODIFIER_PARTY = 0xD80C073B,
	BLIP_MODIFIER_PICKUP_NEW = 0x2818329D,
	BLIP_MODIFIER_PICKUP_PLACEMENT = 0x6299A81F,
	BLIP_MODIFIER_PICKUP_SURVIVAL_MODES = 0x8BE20367,
	BLIP_MODIFIER_PICKUP_UNAVAILABLE = 0x9D67653E,
	BLIP_MODIFIER_PICKUP_WEAPON_LEGENDARY = 0x7E76DC36,
	BLIP_MODIFIER_PICKUP_WEAPON_NEW = 0xB385AA50,
	BLIP_MODIFIER_PICKUP_WEAPON_OF_CHOICE = 0x484251DA,
	BLIP_MODIFIER_PICKUP_WEAPON_OWNED = 0x000F4E8C,
	BLIP_MODIFIER_PICKUP_WEAPON_RARE = 0x9FC111B3,
	BLIP_MODIFIER_PING_GUNSHOT = 0xA1F84FD6,
	BLIP_MODIFIER_PLAYER_HORSE_HITCHED = 0x2178B75B,
	BLIP_MODIFIER_PLAYER_HORSE_INACTIVE = 0x04D33A78,
	BLIP_MODIFIER_PLAYER_HORSE_IN_RANGE = 0xC3A0EF2E,
	BLIP_MODIFIER_PLAYER_HORSE_IN_RANGE_WHISTLE = 0xEFBDD411,
	BLIP_MODIFIER_PLAYER_HORSE_OUT_OF_RANGE = 0x4E4345BA,
	BLIP_MODIFIER_PLAYER_HORSE_OUT_OF_RANGE_WHISTLE = 0x93E00EE2,
	BLIP_MODIFIER_POSSE_ALLY = 0xAD76DF0A,
	BLIP_MODIFIER_POSSE_ALLY_OWNED = 0x1B05ACFB,
	BLIP_MODIFIER_POSSE_ENEMY = 0xD2FC82A6,
	BLIP_MODIFIER_POSSE_ENEMY_OWNED = 0x5E944732,
	BLIP_MODIFIER_POSSE_NEUTRAL_OWNED = 0x617D58CD,
	BLIP_MODIFIER_PREDATOR = 0xA2A1F2EF,
	BLIP_MODIFIER_PREDATOR_5 = 0x7E1022D0,
	BLIP_MODIFIER_PREDATOR_10 = 0x276857A4,
	BLIP_MODIFIER_PULSE_FOREVER = 0xD34253F0,
	BLIP_MODIFIER_PULSE_THREE_TIMES = 0x95BD6684,
	BLIP_MODIFIER_PVP_TARGET = 0x5D20C45A,
	BLIP_MODIFIER_PVP_TARGET_TRACKED = 0x69457DA1,
	BLIP_MODIFIER_RACE_CHECKPOINT_ALT = 0xA908F2D4,
	BLIP_MODIFIER_RADAR_EDGE_ALWAYS = 0x32850803,
	BLIP_MODIFIER_RADAR_EDGE_NEVER = 0xF366785F,
	BLIP_MODIFIER_RADAR_EDGE_PAUSE_MAP_NEVER = 0x54561AD1,
	BLIP_MODIFIER_SCALE_1 = 0x1DC9C9D4,
	BLIP_MODIFIER_SCALE_2 = 0x2ECDEBDC,
	BLIP_MODIFIER_SELECTED_UP_SCALE = 0x701AD0E1,
	BLIP_MODIFIER_SHOP_UNAVAILABLE = 0x470BBD53,
	BLIP_MODIFIER_SHOW_HEIGHT = 0x3E605A6D,
	BLIP_MODIFIER_SHRINK_WARNING_1 = 0x2A8907B4,
	BLIP_MODIFIER_SHRINK_WARNING_2 = 0x384BA339,
	BLIP_MODIFIER_SP_DOWNED = 0xCB6062E0,
	BLIP_MODIFIER_TEMP_HORSE_HITCHED = 0xF4012B77,
	BLIP_MODIFIER_TEST_GPS_MODULE = 0xAAEA1261,
	BLIP_MODIFIER_TEXT_ONLY = 0xF168692F,
	BLIP_MODIFIER_TOD_DAYTIME_ONLY = 0x2E9B7ACE,
	BLIP_MODIFIER_TOD_NIGHTTIME_ONLY = 0x717A8A2E,
	BLIP_MODIFIER_TOWN_POSSE_MEMBER = 0x40BEFB22,
	BLIP_MODIFIER_TRACKING = 0x287E1591,
	BLIP_MODIFIER_TRAIN_MISSION = 0xE1DE479D,
	BLIP_MODIFIER_UNDISCOVERED = 0x794450C7,
	BLIP_MODIFIER_URGENT = 0xFD364272,
	BLIP_MODIFIER_URGENT_ALERT = 0x229A6F60,
	BLIP_MODIFIER_URGENT_ALERT_INTERNAL = 0x57FDBE87,
	BLIP_MODIFIER_VERYHIGH_CATEGORY = 0x6A55DFDE,
	BLIP_MODIFIER_WANTED_PULSE_1 = 0x76674069,
	BLIP_MODIFIER_WANTED_PULSE_2 = 0x8CC46D23,
	BLIP_MODIFIER_WANTED_PULSE_3 = 0x1EC09125,
	BLIP_MODIFIER_WANTED_PULSE_4 = 0x3483BCAB,
	BLIP_MODIFIER_WANTED_PULSE_5 = 0x0266D86E,
	BLIP_MODIFIER_WILDERNESS_CHEST_LONG = 0x271C13F9,
	BLIP_MODIFIER_WITNESS_IDENTIFIED = 0x190F3B7C,
	BLIP_MODIFIER_WITNESS_INVESTIGATING = 0x5E176D3A,
	BLIP_MODIFIER_WITNESS_UNIDENTIFIED = 0xFAA28257
};