FROM jupyter/all-spark-notebook:lab-3.4.3

USER 0

COPY sparkmonitor-2.2.0-py3-none-any.whl /tmp/sparkmonitor-2.2.0-py3-none-any.whl
RUN pip install /tmp/sparkmonitor-2.2.0-py3-none-any.whl && \
    ipython profile create && \
    echo "c.InteractiveShellApp.extensions.append('sparkmonitor.kernelextension')" >> /home/jovyan/.ipython/profile_default/ipython_kernel_config.py && \
    jupyter nbextension install sparkmonitor --py && \
    jupyter nbextension enable  sparkmonitor --py && \
    rm -f /tmp/sparkmonitor-2.2.0-py3-none-any.whl

RUN pip install sparkmagic && \
    jupyter nbextension enable --py --sys-prefix widgetsnbextension && \
    jupyter labextension install "@jupyter-widgets/jupyterlab-manager"

RUN jupyter-kernelspec install /opt/conda/lib/python3.10/site-packages/sparkmagic/kernels/sparkkernel && \
    jupyter-kernelspec install /opt/conda/lib/python3.10/site-packages/sparkmagic/kernels/pysparkkernel && \
    jupyter-kernelspec install /opt/conda/lib/python3.10/site-packages/sparkmagic/kernels/sparkrkernel

# Before notebook script for sparkmagic
COPY ./sparkmagic.sh /usr/local/bin/before-notebook.d/sparkmagic.sh
RUN chmod +x /usr/local/bin/before-notebook.d/sparkmagic.sh

RUN fix-permissions "/home/${NB_USER}"
RUN jupyter labextension install jupyterlab_spark

USER ${NB_UID}