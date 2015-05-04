import logging
import uuid
import time

from mesos.interface import Scheduler
from mesos.native import MesosSchedulerDriver
from mesos.interface import mesos_pb2

logging.basicConfig(level=logging.INFO)

def new_task(offer):
    task = mesos_pb2.TaskInfo()
    id = uuid.uuid4()
    task.task_id.value = str(id)
    task.slave_id.value = offer.slave_id.value
    task.name = "task {}".format(str(id))

    if False:
        # container
        task.container.type = 1
        task.container.docker.image = 'kapliy/aam-lite'
        # aam/latest
        aam_code = task.container.volumes.add()
        aam_code.host_path = '/home/akapliy'
        aam_code.container_path = '/mnt/home'
        aam_code.mode = 2
        # anaconda
        aam_conda = task.container.volumes.add()
        aam_conda.host_path = '/opt/anaconda'
        aam_conda.container_path = '/opt/anaconda'
        aam_conda.mode = 2

    cpus = task.resources.add()
    cpus.name = "cpus"
    cpus.type = mesos_pb2.Value.SCALAR
    cpus.scalar.value = 1

    mem = task.resources.add()
    mem.name = "mem"
    mem.type = mesos_pb2.Value.SCALAR
    mem.scalar.value = 2048

    return task


class HelloWorldScheduler(Scheduler):

    def registered(self, driver, framework_id, master_info):
        logging.info("Registered with framework id: {}".format(framework_id))

    def define_tasks(self):
        self.steps = [s for s in range(2)]

    def resourceOffers(self, driver, offers):
        steps = self.steps
        if not steps:
            time.sleep(60)
            raise ValueError('ALL DONE')
        logging.info("Recieved resource offers: {}".format([o.id.value for o in offers]))
        # whenever we get an offer, we accept it and use it to launch a task that
        # just echos hello world to stdout
        for offer in offers:
            step = steps.pop()
            task = new_task(offer)
            task.command.value = "echo Running step {}".format(step)
            logging.info("Launching task {task} "
                         "using offer {offer}.".format(task=task.task_id.value,
                                                       offer=offer.id.value))
            tasks = [task]
            driver.launchTasks(offer.id, tasks)
            if not steps:
                break

if __name__ == '__main__':
    framework = mesos_pb2.FrameworkInfo()
    framework.user = ""  # Have Mesos fill in the current user.
    framework.name = "runner"
    scheduler = HelloWorldScheduler()
    scheduler.define_tasks()
    driver = MesosSchedulerDriver(
        scheduler,
        framework,
        "zk://localhost:2181/mesos"  # assumes running on the master
    )
    driver.run()
