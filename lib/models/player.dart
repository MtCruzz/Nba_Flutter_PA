class Player {
  final String name;
  final String teamName;
  final String gp;
  final String mpg;
  final String fga;
  final String fgm;
  final String fgp;
  final String ftp;
  final String tpa;
  final String tpm;
  final String tpp;
  final String ppg;
  final String or;
  final String dr;
  final String rpg;
  final String apg;
  final String stl;
  final String blk;
  final String to;

  Player(
      {this.name,
      this.teamName,
      this.gp,
      this.mpg,
      this.fga,
      this.fgm,
      this.fgp,
      this.ftp,
      this.tpa,
      this.tpm,
      this.tpp,
      this.ppg,
      this.or,
      this.dr,
      this.rpg,
      this.apg,
      this.stl,
      this.blk,
      this.to});

  factory Player.fromJson(Map<String, dynamic> json) {
    return Player(
        name: json['name'],
        teamName: json['team_name'],
        gp: json['games_played'],
        mpg: json['minutes_per_game'],
        fga: json['field_goals_attempted_per_game'],
        fgm: json['field_goals_made_per_game'],
        fgp: json['field_goal_percentage'],
        ftp: json['free_throw_percentage'],
        tpa: json['three_point_attempted_per_game'],
        tpm: json['three_point_made_per_game'],
        tpp: json['three_point_percentage'],
        ppg: json['points_per_game'],
        or: json['offensive_rebounds_per_game'],
        dr: json['defensive_rebounds_per_game'],
        rpg: json['rebounds_per_game'],
        apg: json['assists_per_game'],
        stl: json['steals_per_game'],
        blk: json['blocks_per_game'],
        to: json['turnovers_per_game']);
  }
}
