%%%-------------------------------------------------------------------
%%% @author Hiroe Shin <shin@u636188.xgsfmg23.imtp.tachikawa.mopera.net>
%%% @copyright (C) 2012, Hiroe Shin
%%% @doc
%%%
%%% @end
%%% Created : 19 Feb 2012 by Hiroe Shin <shin@u636188.xgsfmg23.imtp.tachikawa.mopera.net>
%%%-------------------------------------------------------------------
-module(postgres_pool).

%% API
-export([squery/2, equery/3]).

%%%===================================================================
%%% API
%%%===================================================================

squery(PoolName, Sql) ->
    Worker = poolboy:checkout(PoolName),
    Reply = gen_server:call(Worker, {squery, Sql}),
    poolboy:checkin(PoolName, Worker),
    Reply.

equery(PoolName, Stmt, Params) ->
    Worker = poolboy:checkout(PoolName),
    Reply = gen_server:call(Worker, {equery, Stmt, Params}),
    poolboy:checkin(PoolName, Worker),
    Reply.

%%%===================================================================
%%% Internal functions
%%%===================================================================
