module MakeTeams
using Random

export maketeams

"""
```julia
maketeams([rng=GLOBAL_RNG,] players::AbstractArray,nteams=2)
```
Divide players into even teams

# Examples
```jldoctest
julia> using MakeTeams
       import Random:MersenneTwister
       rng=MersenneTwister(1234);
       maketeams(rng,["Sue","Bob","Julia","Ralph","Cindy","Tim"],3)
Team 1
Cindy, Ralph
Team 2
Tim, Julia
Team 3
Sue, Bob
```
"""
function maketeams end

function maketeams(rng::AbstractRNG,players::AbstractArray,nteams::Int=2)::Nothing
    if length(players)%nteams != 0 #Players can't be evenly divided among teams
        error("Players cannot be divided evenly")
    end
    players_per_team=length(players)/nteams

    shuffled_players=shuffle(rng,players)
    for teamnum in 1:nteams #for each team
        this_team=[]
        for _ in 1:players_per_team #draw the correct number of players
            push!(this_team,pop!(shuffled_players))
        end
        println("Team $teamnum")
        teamstr=""
        for teammate in this_team
            teamstr=teamstr*"$teammate, "
        end
        println(teamstr[begin:end-2])#trim off trailing comma and space
    end
    return nothing
end

function maketeams(players::AbstractArray,nteams=2)::Nothing
    myrng=Random.Xoshiro()
    maketeams(myrng,players,nteams)
end

end # module
