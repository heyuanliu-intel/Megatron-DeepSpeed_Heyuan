# Copyright (C) 2024 Habana Labs, Ltd. an Intel Company.
# Copyright (c) 2022, NVIDIA CORPORATION. All rights reserved.

import torch

from .global_vars import get_args, get_retro_args
from .global_vars import get_current_global_batch_size
from .global_vars import get_num_microbatches
from .global_vars import get_num_eval_microbatches
from .global_vars import get_num_microbatches_by_mode
from .global_vars import get_signal_handler
from .global_vars import update_num_microbatches
from .global_vars import get_tokenizer
from .global_vars import get_tensorboard_writer
from .global_vars import get_adlr_autoresume
from .global_vars import get_timers
from .initialize  import initialize_megatron

from .utils import (print_rank_0,
                    is_last_rank,
                    is_load_rank,
                    print_rank_last,
                    is_rank_0,
                    is_aml)
