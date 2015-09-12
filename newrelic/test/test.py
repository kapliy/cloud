#!/usr/bin/env python

import sys
import newrelic.agent
newrelic.agent.initialize()

import os
import datetime
import numpy as np
import pandas as pd
import time
import resource
from datalib.MarketData import MarketData
from datalib.Reference import Reference
from util.Frame import Frame
from util.Dates import parse_date

## @newrelic.agent.background_task(name='testing-newrelic-on-a-function', group='Task')
def frame_numpy_task(size=3000, dt='2015-01-02'):
    transaction = newrelic.agent.current_transaction()
    endpoint = 'frame_numpy_task'

    md = MarketData()

    with newrelic.agent.FunctionTrace(transaction, endpoint+'.'+'Frame.query', 'Python/EndPoint'):
        ddf = Frame.query('DBRND02-DEV01', """
        select * from Reference.dbo.refIdentifier where ValidTo='9999-12-31'
        and '{}' between DateActive and DateInactive
        and IdentifierTypeID in (50,51) 
        """.format(dt)).to_pandas()
        print ddf

    with newrelic.agent.FunctionTrace(transaction, endpoint+'.'+'MarketData.caps', 'Python/EndPoint'):
        caps = md.caps(dt, dt, issuer_level=True)
        print 'World cap (non-golden) on {}: {}'.format(dt, caps.CompanyCapUSD.sum())

    with newrelic.agent.FunctionTrace(transaction, endpoint+'.'+'MarketData.caps_golden', 'Python/EndPoint'):
        caps = md.caps(dt, dt, issuer_level=True, golden=True)
        print 'World cap (golden) on {}: {}'.format(dt, caps.CompanyCapUSD.sum())

    with newrelic.agent.FunctionTrace(transaction, endpoint+'.'+'np.random.randn', 'Python/EndPoint'):
        df = pd.DataFrame(np.random.randn(size, size))
        print 'DataFrame mean: ', df.mean().mean()

    with newrelic.agent.FunctionTrace(transaction, endpoint+'.'+'np.linalg.inv', 'Python/EndPoint'):
        t0 = time.time()
        dinv = np.linalg.inv(df)
        t1 = time.time()
        print 'Time: %.3f secs' % (t1-t0)
        print 'Memory: %.1f MB' % (resource.getrusage(resource.RUSAGE_SELF).ru_maxrss / 1024.0)

    return dinv


if __name__ == '__main__':
    application = newrelic.agent.register_application(timeout=2.0)
    size = 3500
    dt0 = '2015-01-02'
    for i in range(10):
        dt = parse_date(dt0) + datetime.timedelta(days=i)
        with newrelic.agent.BackgroundTask(application, name='frame_numpy_task', group='Task'):
            newrelic.agent.add_custom_parameter('matrix_size', size)
            newrelic.agent.add_custom_parameter('start_date', str(dt))
            print 'Running', i, dt
            frame_numpy_task(size, dt)
    newrelic.agent.shutdown_agent(timeout=2.0)
